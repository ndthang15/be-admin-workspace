const redis = require('redis');
const _ = require('lodash');
const { promisify } = require('util');

module.exports = function createFunction(app) {
    const defaultTtlMin = process.env.REDIS_TTLMIN || 60;
    const redisConfigs = {
      host: process.env.REDIS_HOST || 'localhost',
      port: process.env.REDIS_PORT || 6379
    }

    const redisClient = redis.createClient(redisConfigs);

    redisClient.on('error', (err) => {
      console.error('redis connection failure!', err);
    });
    redisClient.on('connect', () => {
      console.log('redis connected');
    });

    function _get(key, callback) {
      redisClient.get(key, (error, val) => {
        callback(error, val);
      });
    }

    function _set(key, value, ttl, callback) {
      if (!ttl) {
        redisClient.set(key, value, callback);
        return;
      }
      redisClient.set(key, value, 'EX', ttl, (error, val) => {
        callback(error, val);
      });
    }

    const getAsync = promisify(_get);
    const setAsync = promisify(_set);

    async function clear(key) {
      if (!redisClient.connected) return null;
  
      const start = Date.now();
      // Don't need to wait the delete process
      redisClient.del(key, () => {
        console.log(
          `Redis DEL ${key} in ${Date.now() - start}`
        );
      });
    }

    async function set(key, value, ttlMin = null) {
      if (!redisClient.connected) return;
      if (_.isNil(value)) {
        throw new Error('null/undefined cannot be cached in redis. use clear().');
      }
  
      const start = Date.now();
      const res = await setAsync(key, JSON.stringify(value), ttlMin * 60); // Note that redis cache TTL is in seconds
  
      console.log(
        `Redis SET ${key} ttlMin: ${ttlMin} in ${Date.now() - start}`
      );
  
      return res;
    }

    async function get(key) {
      if (!redisClient.connected) return null;
      const start = Date.now();
      const res = await getAsync(key);
      const elapsed = Date.now() - start;

      if (res) {
        console.log(`Redis HIT ${key} in ${elapsed}`);
      } else {
        console.log(`Redis MISS ${key} in ${elapsed}`);
      }
  
      try {
        return _.isNil(res) ? res : JSON.parse(res);
      } catch (err) {
        console.warn('Invalid redis cache value for ' + key);
        redisClient.del(key);
        return null;
      }
    }

    return { set, get, clear };
}
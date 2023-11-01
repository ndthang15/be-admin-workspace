const _ = require('lodash');

module.exports = (app) => {
  async function getRole(roleId) {
    const role = await app.dal.roles.getRole(roleId);
    return role;
  }

  async function getRoles(options) {
    const roles = await app.dal.roles.getRoles(options);
    return roles;
  }

  async function createRole(params) {
    const newRole = await app.dal.roles.createRole(params);
    return newRole;
  }

  async function updateRole(params) {
    const updatedRole = await app.dal.roles.updateRole(params);
    return updatedRole;
  }

  async function deleteRole(roleId) {
    const deletedRole = await app.dal.roles.deleteRole(roleId);
    return deletedRole;
  }

  return { getRole, getRoles, createRole, updateRole, deleteRole};
};

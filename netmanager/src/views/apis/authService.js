import axios from "axios";
import constants from "../../config/constants";

export const updateUserPasswordApi = async (userId, tenant, userData) => {
  return await axios
    .put(constants.UPDATE_PWD_IN_URI, userData, {
      params: { tenant, id: userId },
    })
    .then((response) => response.data);
};

import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  id_user: "",
  username: "",
  email: "",
  access_token: "",
  role: "",
};

export const userSlice = createSlice({
  name: "user",
  initialState,
  reducers: {
    setUser: (state, action) => {
      const { id_user, username, email, access_token, role } =
        action.payload || {};
      state.id_user = id_user || "";
      state.username = username || "";
      state.email = email || "";
      state.access_token = access_token || "";
      state.role = role || "";
    },
  },
});

export const { setUser } = userSlice.actions;

export default userSlice.reducer;

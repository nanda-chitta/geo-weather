import { createSlice } from '@reduxjs/toolkit';
import {dispatch} from './store';

const initialState = {
  user: JSON.parse(window?.localStorage.getItem('user') as any) ?? {},
  isFetching: false,
  error: null,
}

const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setUser(state, action) {
      state.user = action.payload;
      localStorage.setItem('user', JSON.stringify(action.payload));
    },
    setIsFetching(state, action) {
      state.isFetching = action.payload;
    },
    setError(state, action) {
      state.error = action.payload;
    },
  },
})

export default userSlice.reducer;
import { createSlice } from '@reduxjs/toolkit';

const initialState = {
  //@ts-ignore
  theme: JSON.parse(window?.localStorage.getItem('theme')) ?? 'dark',
};

const themeSlice = createSlice({
  name: 'theme',
  initialState,
  reducers: {
    setTheme(state, action) {
      state.theme = action.payload;
      localStorage.setItem('theme', JSON.stringify(action.payload));
    },
  },
});

export default themeSlice.reducer;

export function SetTheme(value: any) {
  return (dispatch: any) => {
    dispatch(themeSlice.actions.setTheme(value));
  };
}
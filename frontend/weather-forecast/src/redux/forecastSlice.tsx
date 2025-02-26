import { createSlice } from '@reduxjs/toolkit';

const initialState = {
  forecast: {}
}

const forecastSlice = createSlice({
  name: 'forecast',
  initialState,
  reducers: {
    getForecast(state, action) {
      state.forecast = action.payload;
    },
  },
})

export default forecastSlice.reducer;

export function SetForecast(forecast: any) {
  return (dispatch: any, getState: any) => {
    dispatch(forecastSlice.actions.getForecast(forecast));
  };
}
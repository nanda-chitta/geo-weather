import { combineReducers } from '@reduxjs/toolkit';

import userSlice from './userSlice';
import themeSlice from './theme';
import forecastSlice from './forecastSlice'; // Add other slices here as needed.

const rootReducer = combineReducers({
  theme: themeSlice,
  user: userSlice,  // Add other reducers here as needed.
  forecast: forecastSlice, // Add other reducers here as needed.
});

export { rootReducer };
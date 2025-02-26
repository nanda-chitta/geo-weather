import axios from 'axios';
import {dispatch} from '../redux/store';
import {SetForecast} from '../redux/forecastSlice';

const API_URl = 'http://localhost';

export const API = axios.create({
  baseURL: API_URl,
  responseType: 'json'
})

export const fetchRequest = async ({ url, data, method }: any) => {
  try {
    const response: any = await API(url, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      data: data || {},
      method: method || 'GET'
    });
    return response?.data;
  } catch (error) {
    console.log(error);
  }
}


export const searchForecast = async (data: any, dispatch: any) => {
  const dataStr = data ? data?.search?.trim() : '';
   try {
     const response = await fetchRequest({
       url: `/api/v1/forecasts/search?search=${dataStr}`,
       method: 'GET',
       data: dataStr,
     });

     dispatch(SetForecast(response?.data)); // Dispatch action to update forecasts in Redux store
     return;
   }catch (error) {
     console.log(error);
   }
}
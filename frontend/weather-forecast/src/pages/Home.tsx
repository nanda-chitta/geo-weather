import React, {useEffect, useState} from 'react';
import {LoadForecast, Loading, TopBar} from '../components'
import {useDispatch, useSelector} from 'react-redux';
import {searchForecast} from "../services";

const Home = () => {

  const [loading, setLoading] = useState(false);
  // @ts-ignore
  const { forecast } = useSelector((state) => state?.forecast);
  const dispatch = useDispatch();

  const fetchForecast = async () => {
    await searchForecast('', dispatch);
    setLoading(false);
  }

  useEffect(() => {
    setLoading(true);
    fetchForecast();
  }, []);

  return(
    <>
      <div className='w-full px-0 bg-bgColor lg:rounded-lg h-screen overflow-hidden'>
        <TopBar />
        {/* Homepage content goes here */}
        <div className='flex-1 h-full px-4 flex flex-col gap-6 overflow-y-auto rounded-lg py-3 md:py-4 lg:px-10 pb-20 2xl:px-40'>
          <div className='w-full flex flex-col gap-2 bg-primary py-4 px-4 rounded-lg'>
            <div className='flex flex-col gap-4 items-center'>
              <h2 className='text-small text-ascent-1 font-semibold'>Welcome to Weather Forecast</h2>
              <p className='text-sm text-ascent-1 text-gray-600'>Get the latest weather updates for your city</p>
            </div>
            <div className='flex flex-col gap-4 items-center'>
              {
                loading ? (
                  <Loading/>
                ) : (
                  <LoadForecast forecast={forecast} />
                )
              }
            </div>
          </div>
        </div>
        {/* Weather data goes here */}
        {/* Search bar goes here */}
        {/* Footer goes here */}
      </div>
    </>
  )
}

export default Home;

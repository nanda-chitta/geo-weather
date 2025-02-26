import React, {useState} from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
// import TextInput from './TextInput';
// import CustomButton from './CustomButton';
import { useForm } from 'react-hook-form';
import { BsMoon, BsSunFill } from 'react-icons/bs';
import { IoMdNotificationsOutline } from 'react-icons/io';
import { TbSocial } from 'react-icons/tb';
import {SetTheme} from '../redux/theme';
import {CustomButton, TextInput} from "./index";
import {searchForecast} from '../services';

const TopBar = () => {
  // @ts-ignore
  const { theme } = useSelector((state) => state.theme);
  const dispatch = useDispatch();

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();

  const handleTheme = () => {
    const themeValue = theme === 'light' ? 'dark' : 'light';
    // @ts-ignore
    dispatch(SetTheme(themeValue));
  };

  const handleSearch = async (data: any) => {
    console.log('search data', data);
    await searchForecast(data, dispatch);
  };

  return (
    <div className='topbar w-full flex items-center justify-between py-3 md:py-4 px-4 bg-primary lg:px-10 pb-20 2xl:px-40'>
      <Link to='/' className='flex gap-2 items-center'>
        <div className='p-1 md:p-2 bg-[#065ad8] rounded text-white'>
          <TbSocial />
        </div>
        <span className='text-xl md:text-2xl text-[#065ad8] font-semibold'>
          Forecast
        </span>
      </Link>

      <form
        className='hidden md:flex items-center justify-center'
        onSubmit={handleSubmit(handleSearch)}
      >
        <TextInput
          placeholder='Search for a city...'
          styles='w-[18rem] lg:w-[38rem] rounded-l-full py-3'
          register={register("search")}
        />
        <CustomButton
          title='Search'
          type='submit'
          containerStyles='bg-[#0444a4] text-white px-6 py-3 mt-2 rounded-r-full'
        />
      </form>

      {/* ICONS */}
      <div className='flex gap-4 items-center text-ascent-1 text-md md:text-xl'>
        <button onClick={() => handleTheme()}>
          {theme ? <BsMoon /> : <BsSunFill />}
        </button>
        <div className='hidden lg:flex'>
          <IoMdNotificationsOutline />
        </div>
      </div>
    </div>
  );
};

export default TopBar;

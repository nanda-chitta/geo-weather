import React from 'react'
import {WiSunrise, WiSunset} from "react-icons/wi";

const LoadForecast = ({forecast}: any) => {

  return (
    <>
      <div
        className="flex flex-col items-center justify-center w-screen min-h-screen py-10">
        <div
          className='flex-1 w-full justify-center max-w-screen-sm bg-primary p-10 rounded-xl ring-8 ring-ascent-1 ring-opacity-40'>
          {
            forecast ? (
              <div className='gap-2 justify-center'>
                <div className="flex justify-between border-b border-[#66666645] py-2">
                  <div className="flex-1 justify-center text-center py-4">
                    <span className="text-2xl text-center text-ascent-1 font-bold">{forecast?.city}</span>
                  </div>
                </div>
                <div className="flex justify-between px-2 py-4">
                  <span className="text-xl text-ascent-1 font-semibold">{forecast?.date}</span>
                  <span className="text-sm text-ascent-1 font-semibold">{forecast?.time}</span>
                </div>
                <div className="flex justify-between px-2 py-6">
                  <div className="flex flex-col items-center">
                    <span className="text-3xl text-ascent-1 font-bold">{forecast?.temperature}°C</span>
                    <span className="font-semibold text-ascent-1 pt-8">{forecast?.city}</span>
                  </div>
                  <div className="flex flex-col items-center">
                    <img src={forecast?.iconUrl} alt={forecast?.description} width={100} height={100}
                         className='bg-none fill-white border-[#66666645] rounded -mt-6'/>
                    <span className="text-sm font-semibold text-ascent-1">{forecast?.description}</span>
                  </div>
                </div>
                <div className="flex justify-between px-2">
                  <div className="flex flex-col items-center">
                    <span className="text-sm text-ascent-1 font-semibold">Min Temp: {forecast?.temperature_min}%</span>
                  </div>
                  <div className="flex flex-col items-center">
                    <span
                      className="text-sm text-ascent-1 font-semibold">Max Temp: {forecast?.temperature_max} m/s</span>
                  </div>
                </div>
                <div className="flex justify-between px-2 py-6">
                  <div className="flex flex-col items-center">
                    <WiSunrise className='text-6xl text-ascent-1'/>
                    <span className="text-sm font-semibold text-ascent-1">Sunrise: {forecast?.sunrise}</span>
                  </div>
                  <div className="flex flex-col items-center">
                    <WiSunset className='text-6xl text-ascent-1'/>
                    <span className="text-sm font-semibold text-ascent-1">Sunset: {forecast?.sunset}</span>
                  </div>
                </div>
                <div className="flex justify-between px-2 py-6">
                  <div className="flex flex-col items-center">
                    <span className="text-sm text-ascent-1 font-semibold">Humidity: {forecast?.humidity}%</span>
                  </div>
                  <div className="flex flex-col items-center">
                    <span className="text-sm text-ascent-1 font-semibold">Wind Speed: {forecast?.wind_speed} m/s</span>
                  </div>
                  <div className="flex flex-col items-center">
                    <span className="text-sm text-ascent-1 font-semibold">Pressure: {forecast?.pressure} m/s</span>
                  </div>
                </div>
              </div>
            ) : (
              <div className='flex justify-center mt-12'>
                <h3>No Forecast</h3>
              </div>
            )
          }
        </div>
      </div>
    </>
  )
}
export default LoadForecast

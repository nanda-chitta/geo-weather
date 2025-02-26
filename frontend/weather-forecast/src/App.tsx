import React, {FC} from 'react';
import { useSelector } from 'react-redux';
import AuthProvider from './providers/AuthProvider';
import Routes from './routes';
import './index.css';

const App: FC = () => {
  //@ts-ignore
  const { theme } = useSelector((state) => state.theme);

  return (
    <div data-theme={theme} className='w-full min-h-[100vh]'>
      <AuthProvider>
        <Routes />
      </AuthProvider>
    </div>
  );
}

export default App;

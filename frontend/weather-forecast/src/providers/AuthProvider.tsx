import axios from 'axios';
import {createContext, useContext, useEffect, useMemo, useState} from 'react';
import { useSelector } from 'react-redux';

//@ts-ignore
export const AuthContext = createContext();

const AuthProvider = ({children}: any) => {

  //@ts-ignore
  const {user} = useSelector((state) => state?.user);
  const [token, setToken_] = useState('');

  const setToken: any = (newToken: any) => {
    setToken_(newToken);
  }

  useEffect(() => {
    if (user) {
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      window?.localStorage?.setItem('user', JSON.stringify({token: token}));
    }else {
      delete axios.defaults.headers.common['Authorization'];
      window?.localStorage?.removeItem('user');
    }
  }, [token]);

  const contextValue = useMemo(() => ({
    token,
    setToken,
  }),
    [token]
  );

  return (
    <AuthContext.Provider value={contextValue}>{children}</AuthContext.Provider>
  );
};


export const useAuth = () => {
  return useContext(AuthContext);
}

export default AuthProvider;

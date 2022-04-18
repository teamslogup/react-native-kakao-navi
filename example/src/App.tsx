import React, { useEffect } from 'react';
import { Button } from 'react-native';
import { initSdk, navigate } from 'react-native-kakao-navi';

export default function App() {
  useEffect(() => {
    initSdk('31fee9db84bdc3cc972398458af74851');
  }, []);

  const kakaoNavigate = () => {
    navigate({
      name: '판교역',
      x: '126.977983',
      y: '37.594943',
    });
  };

  return <Button onPress={kakaoNavigate} title="Kakao Navi" />;
}

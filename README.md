# react-native-kakao-navi

## Description
kakao-navi navigation for React-native

</br>

## How to use
```tsx
import React, { useEffect } from 'react';
import { Button, SafeAreaView, StyleSheet } from 'react-native';
import { initSdk, navigate } from 'react-native-kakao-navi';

export default function App() {
  useEffect(() => {
    initSdk('YOUR KAKAO SDK KEY');
  }, []);

  const kakaoNavigate = () => {
    /*
      Location {
        name: string;
        x: string; (longitude)
        y: string; (latitude)
      }
    */
    navigate({
      name: '판교역',
      x: '126.977983',
      y: '37.594943',
    });
  };

  return (
    <SafeAreaView style={styles.container}>
      <Button onPress={kakaoNavigate} title="Kakao Navi" />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

```

</br>

## Installation

1. Package.json
```json
  "dependencies": {
    ...
    "react-native-kakao-navi": "git+https://github.com/teamslogup/react-native-kakao-navi.git",
```
2. yarn install
3. (For iOS) cd ios && pod install

</br>

## Setup
### 1. Android
### android root/build.gradle
```gradle
allprojects {
    repositories {
        ...
        maven { url 'https://devrepo.kakao.com/nexus/content/groups/public/'}
    }
}

```

### 2. iOS
### Info.plist
```plist
<key>LSApplicationQueriesSchemes</key>
<array>
  ...
  <string>kakaonavi-sdk</string>
</array>
```

</br>

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

</br>

## License

MIT

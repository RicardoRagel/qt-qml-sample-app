# Qt-QML Sample App

Simple Qt Application project with front-end developed using QML. The aim of this app is to be used as example or template project to develop other Qt apps.

<p align="center">
    <img src="readme_sample.png" width="900">
</p>

If you want to just use it, you can go directly to the [Releases](https://github.com/robotics-upo/haru-routines-creator/releases/latest) page of this repository and download the last AppImage Linux executable. Developers must install all the dependecies and follow the installation steps.

## Dependencies

* Multi-platform: Linux and Windows

* [Qt + QtCreator](https://www.qt.io/download). Created using Qt 5.14.2

No other libraries different from the provided by Qt have been used to simplify the example.

## Installation

Just open the project file [sample_app.pro](haru_routines_creator.pro) using **QtCreator**, configure the project using the default settings and compile.


## Deploying the App for Linux

To create a self-contained executable easily, we recommend the [AppImage](https://github.com/probonopd/linuxdeployqt) tool. You can also get the current deployed AppImage of this app from **Releases** page of this repository. If you want to create one by yourself, follow the instructions described in the file [AppImage/HowTo.md](AppImage/HowTo.md).

## Deploying the App for Windows

In this case, we are going to use the `windeployqt` tool, following the steps from: [Qt for Windows - Deployment](https://doc.qt.io/qt-5/windows-deployment.html):

1. Open a terminal and setup your Qt enviroment executing the script `QTDIR/bin/qtenv2`. In my case this path is: 

    ```bash
    C:\Users\Ricardo\Qt\5.14.2\mingw73_32\bin\qtenv2.bat
    ```

2. Open QtCreator, configure your project to be built as Release in a specific folder (from now, we are going to refer to this folder as **BUILD_FOLDER**) and build it. You should have an .exe file in the path `BUILD_FOLDER/release` togehter the rest of the libraries, headers, and so on. In my case, this is file is: `C:\Users\Ricardo\Libraries\build-sample_app-Desktop_Qt_5_14_2_MinGW_32_bit-Release\release\sample_app.exe`.

3. Remove all the files except the .exe file.

4. Execute the `windeployqt` tool together the path to your QML **sources** and the path to the previous executable file (set the rest of the options if you need them): 

    ```bash
    windeployqt --qmldir <PATH_TO_YOUR_QML_SOURCES> <... OTHER_OPTIONS ...> <PATH_TO_YOUR_EXE_FILE>
    ```

    In my case this command looks like it: `windeployqt --qmldir C:\Users\Ricardo\Libraries\qt-qml-sample-app\qml --no-translations sample_app.exe`.

5. After execute the previous tool, you should have all the necessary Qt libraries (DLL), headers, plugins, ... together the previous executable (sample_app.exe in my case), and you should be able to run it (double click) in this machine or in any other machine just copying to it the whole `BUILD_FOLDER/release` folder. 

So far, you have already a deployable folder containing the App executable along with all the Qt libraries dependencies, so you can share directly this folder to the rest of the App users. 

If you are interested in creating a installer, continue reading: [Qt Installer Framework](https://www.walletfox.com/course/qtinstallerframeworkexample.php)
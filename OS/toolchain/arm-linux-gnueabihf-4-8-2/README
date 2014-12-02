
imx6 부트로더와 커널을 빌드하기 위한 툴체인 사용법입니다.
기존 4.6.3과 동일하게 사용가능합니다. (아래 테스트 결과 참고)

 
            Linaro GCC 4.6.3 32bit    Linaro GCC 4.8.2 32bit(2013.10)      
Nadia-F1            O                   O
iMX6Q-COM           O                   O

            <커널, 부트로더 모두 테스트 한 결과임>


현재 본 저장소의 툴체인 압축 패키지는 아래의 사이트에서 가져왔습니다.

https://launchpad.net/linaro-toolchain-binaries

또한 apt-get을 이용해서 아래 패키지를 설치해도 동일하게 사용 가능합니다.(마찬가지로 위의 사이트에서 가져옵니다)
이 경우 여러개의 툴체인을 사용하시는 경우 꼬일 수 있으니 아래의 압축 패키지를 이용하는 것을 추천합니다.

gcc-4.8-arm-linux-gnueabihf - GNU C compiler
gcc-4.8-arm-linux-gnueabihf-base - GCC, the GNU Compiler Collection (base package)

apt-get install gcc-4.8-arm-linux-gnueabihf
또는 apt-get install gcc-4.8-arm-linux-gnueabihf-base


아래는 툴체인에 대한 간단한 정보입니다. 툴체인에 대한 더 자세한 정보와 버전정보, 
리눅스 버전을 제외한 OS를 위한 패키지는 위의 페이지를 참고하세요


This is a pre-built version of Linaro GCC and Linaro GDB that runs on generic Linux or Windows and targets the glibc Linaro Evaluation Build.

Uses include:
 * Cross compiling ARM applications from your laptop
 * Remote debugging
 * Build the Linux kernel for your board

The Linux version is supported on Ubuntu 10.04.3 and 11.10, Debian 6.0.2, Fedora 16, openSUSE 12.1, Red Hat Enterprise Linux Workstation 5.7 and later, and should run on any Linux Standard Base 3.0 compatible distribution. Please see the README about running on x86_64 hosts.

The Windows version is supported on Windows XP Pro SP3, Windows Vista Business SP2, and Windows 7 Pro SP1.



우분투 리눅스 64비트는 아래와 같이 ia32-libs를 설치해야 합니다. 

sudo apt-get install ia32-libs

우분투 64비트 14.04 LTS의 경우 아래와 같이 대체 패키지를 모두 설치하시면 됩니다.

sudo apt-get install lib32z1 lib32ncurses5 lib32bz2-1.0





다운로드 받은 툴체인 압축 패키지의 압축을 해제 합니다.

tar -xvzf gcc-linaro-arm-linux-gnueabihf-4.8-2013.10_linux.tar.xz

압축을 해제한 디렉토리의 bin디렉토리로 이동합니다.

cd gcc-linaro-arm-linux-gnueabihf-4.8-2013.10_linux/bin

해당 디렉토리의 경로를 PATH 변수에 등록합니다.

export PATH=$PATH:$PWD

제대로 환경변수 등록이 되어 있는지 echo합니다.

echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/simon/dev-tools/EmbeddedArm/stlink/:/home/simon/toolchain/gcc-linaro-arm-linux-gnueabihf-4.8-2013.10_linux/bin

테스트를 위해 홈디렉토리로 이동해서 다음 명령어를 입력해봅니다.

~/toolchain/gcc-linaro-arm-linux-gnueabihf-4.8-2013.10_linux/bin) cd ~
~) arm-linux-gnueabihf-gcc
arm-linux-gnueabihf-gcc: fatal error: no input files
compilation terminated.
~) 


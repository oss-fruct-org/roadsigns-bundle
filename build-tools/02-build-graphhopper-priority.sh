mkdir -p build
cd build

git clone https://github.com/ivashov/graphhopper-priority.git
cd graphhopper-priority
./gradlew jar
cp ./build/libs/graphhopper-priority-1.3.2.jar $1/lib

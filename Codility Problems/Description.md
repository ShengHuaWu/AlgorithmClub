# Codility Problems
## Hard drive statistics
Your computer's hard driver is almost full. In order to make some space, you need to compile some file statistics. You want to know how many bytes of memory each file type is consuming. Each file has a name, and the part of the name after the last dot is called the file extension, which identifies what type of file it is.
* music (only extensions: mp3, aac, flac)
* image (only extensions: jpg, bmp, gif)
* movie (only extensions: mp4, avi, mkv)
* other (all other extensions; for example: 7z, txt, zip)
You receive string `S`, containing a list of all the files in your computer (each file appears on a separate line). Each line contains a file name and the file's size in bytes, separated by a space. For example, 
```
"my.song.mp3 11b
greatSong.flac 1000b
not3.txt 5b
video.mp4 200b
game.exe 100b
mov!e.mkv 10000b"
``` 
In total there are 1011 bytes of music, 0 byte of images, 10200 bytes of movies, and 105 bytes of other files. Write a function:
```
class Solution {
    public String solution(String S);
}
```
that, given string S describing the files on disk, returns a string containing four rows, describing music, images, movies, and other file types respectively. Each row should consist of a file type and the number of files consumed by files of that type on disk. For instance, given string `S` as shown above, your function should return:
```
"music 1011b
images 0b
movies 10200b
other 105b"
```

### Reference 
https://github.com/dhruv88esh/DatalexCodilitySolutions/blob/master/src/com/datalex/solutions/HardDiskStatistics.java

## Minimum distance of adjacent
Integer `V` lies strickly between integer `U` and `W` if `U < V < W` or `W < V < U`. A non-empty array `A` consisting of `N` integers is given. A pair of indices (`P`, `Q`), where `0 <= P < Q < N` is said to have adjacent values if no value in the array lies strickly between values `A[P]` and `A[Q]`. For example, in array `A` such as
```
[0, 3, 3, 7, 5, 3, 11, 1]
```
Indices 4 and 5 have adjacent values because there is no value in `A` that lies strickly between `A[4] = 5` and `A[5] = 3`; the only such value could be the number 4, and it's not presented in the array.
Given two indices `P` and `Q`, their distance is defined as `abs(A[P] - A[Q])`. Write a function
```
class Solution {
    public int solution(int[] A);
}
```
that, given a non-empty array `A` consisting of `N` integers, returns the minimum distance between indices of this array that have adjacent values. The function should return `-1` if the minimum distance if greater than 100,000,000. The function should retunr `-2` if no adjacent indices exist. For instance, given the array `A` as shown above the function should return 0.

### Reference
https://browsespot.blogspot.com/2018/04/minimum-distance-of-adjacent-pair-in.html

## Maximum waiting time for cars in fuel station
There is a queue of `N` cars waiting at a filling station. There are three dispensers at the station, labeled `X`, `Y`, and `Z`, respectively. Each dispenser has some finite amount of fuel in it; all times the amount of available fuel is clearly displayed on each dispenser.
When a car arrives at the front of the queue, the driver can choose to drive to any dispenser not occupied by another car. Suppose the fule demand is `D` liters of this car. The driver must choose the dispenser which has at least `D` liters of fuel. If all unoccupied dispensers have less than `D` liters, the driver must wait for some other car to finish tanking up. If all dispensers are unoccupied and none has at least `D` liters, the driver is unable to refuel the car and it blocks the queue indefinitely. If more than one unoccupied dispensers have at least `D` liters, the driver chooses the one that labeled with the smallest letter among them.
Each driver will have to wait some amount of time before he or she starts refueling the car. Calculate the maximum waiting time among all drivers. Assume that tanking one liter of fuel takes exactly one second, and moving cars is instantaneous. Write a function
```
class Solution {
    public int solution(int[] A, int X, int Y, int Z);
}
```
that, given an array `A` consisting of `N` integers (which specify the fuel demands in liters for subsequence cars in the queue), and number `X`, `Y`, and `Z` (which specify the initial amount of fuel in the respective dispensers), returns the maximum waiting time for a car. If any car is unable to refuel, the function should return `-1`. For example, given `X = 7`, `Y = 11`, `Z = 3` and the following array `A`
```
[2, 8, 4, 3, 2]
```
The function should return 8.

### Reference
https://leetcode.com/discuss/interview-question/524127/Codility-or-Find-maximum-waiting-time-for-Cars-in-Fuel-Station

## Traveling salesman problem
### Reference
https://www.baeldung.com/java-simulated-annealing-for-traveling-salesman

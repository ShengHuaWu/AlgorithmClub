/*
    Your computer's hard driver is almost full. In order to make some space, you need to compile some file statistics.
    You want to know how many bytes of memory each file type is consuming.
    Each file has a name, and the part of the name after the last dot is called the file extension, which identifies what type of file it is.
    * music (only extensions: mp3, aac, flac)
    * image (only extensions: jpg, bmp, gif)
    * movie (only extensions: mp4, avi, mkv)
    * other (all other extensions; for example: 7z, txt, zip)
    You receive string `S`, containing a list of all the files in your computer (each file appears on a separate line).
    Each line contains a file name and the file's size in bytes, separated by a space. For example,
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
    that, given string S describing the files on disk, returns a string containing four rows, describing music, images, movies, and other file types respectively.
    Each row should consist of a file type and the number of files consumed by files of that type on disk.
    For instance, given string `S` as shown above, your function should return:
    ```
    "music 1011b
    images 0b
    movies 10200b
    other 105b"
    ```

    Reference:
    https://github.com/dhruv88esh/DatalexCodilitySolutions/blob/master/src/com/datalex/solutions/HardDiskStatistics.java
 */

import java.util.Arrays;
import java.util.Set;

public class HardDriverStatistics {
    enum FileType {
        MUSIC,
        IMAGE,
        MOVIE,
        OTHER
    }

    static class File {
        static final private Set<String> musicExtensions = Set.of("mp3", "aac", "flac");
        static final private Set<String> imageExtensions = Set.of("jpg", "bmp", "gif");
        static final private Set<String> movieExtensions = Set.of("mp4", "avi", "mkv");

        FileType type;
        int size;

        File(FileType type, int size) {
            this.type = type;
            this.size = size;
        }
    }

    static class Statistic {
        int musicSize;
        int imagesSize;
        int moviesSize;
        int otherSize;

        Statistic() {
            this.musicSize = 0;
            this.imagesSize = 0;
            this.moviesSize = 0;
            this.otherSize = 0;
        }

        private Statistic(int musicSize, int imagesSize, int moviesSize, int otherSize) {
            this.musicSize = musicSize;
            this.imagesSize = imagesSize;
            this.moviesSize = moviesSize;
            this.otherSize = otherSize;
        }

        @Override
        public String toString() {
            return "music " + musicSize + "b" +
                    "\nimages " + imagesSize + "b" +
                    "\nmovies " + moviesSize + "b" +
                    "\nother " + otherSize + "b";
        }

        static Statistic combine(Statistic s1, Statistic s2) {
            return new Statistic(
                    s1.musicSize + s2.musicSize,
                    s1.imagesSize + s2.imagesSize,
                    s1.moviesSize + s2.moviesSize,
                    s1.otherSize + s2.otherSize);
        }
    }

    static void printHardDriverStatistics() {
        System.out.print("Print hard driver statistics: \n");
        String S = "my.song.mp3 11b\n"
                + "greatSong.flac 1000b\n"
                + "not3.txt 5b\n"
                + "video.mp4 200b\n"
                + "game.exe 100b\n"
                + "mov!e.mkv 10000b";
        System.out.print("Result: \n" + getHardDriverStatistics(S));
    }

    private static String getHardDriverStatistics(String S) {
        return Arrays.stream(S.split("\\r?\\n"))
                .map(HardDriverStatistics::parseToFile)
                .reduce(new Statistic(), HardDriverStatistics::aggregate, Statistic::combine)
                .toString();
    }

    private static Statistic aggregate(Statistic statistic, File file) {
        switch (file.type) {
            case MUSIC:
                statistic.musicSize += file.size;
                break;
            case IMAGE:
                statistic.imagesSize += file.size;
                break;
            case MOVIE:
                statistic.moviesSize += file.size;
                break;
            case OTHER:
                statistic.otherSize += file.size;
                break;
            default:
                throw new IllegalStateException("Unexpected value: " + file.type);
        }
        
        return statistic;
    }

    private static File parseToFile(String text) {
        String extension = text.substring(text.lastIndexOf(".") + 1, text.lastIndexOf(" "));
        int size = Integer.parseInt(text.substring(text.lastIndexOf(" ") + 1, text.lastIndexOf("b")));
        if (File.musicExtensions.contains(extension)) {
            return new File(FileType.MUSIC, size);
        } else if (File.imageExtensions.contains(extension)) {
            return new File(FileType.IMAGE, size);
        } else if (File.movieExtensions.contains(extension)) {
            return new File(FileType.MOVIE, size);
        } else {
            return new File(FileType.OTHER, size);
        }
    }
}

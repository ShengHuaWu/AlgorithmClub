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
    static class File {
        String type;
        int size;

        File(String type, int size) {
            this.type = type;
            this.size = size;
        }
    }

    static final private Set<String> musicExtensions = Set.of("mp3", "aac", "flac");
    static final private Set<String> imageExtensions = Set.of("jpg", "bmp", "gif");
    static final private Set<String> movieExtensions = Set.of("mp4", "avi", "mkv");

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
        File[] files = Arrays.stream(S.split("\\r?\\n")).map(HardDriverStatistics::parseToFile).toArray(File[]::new);
        int musicSize = 0;
        int imagesSize = 0;
        int moviesSize = 0;
        int otherSize = 0;

        for (File file : files) {
            switch (file.type) {
                case "music":
                    musicSize += file.size;
                    break;
                case "images":
                    imagesSize += file.size;
                    break;
                case "movies":
                    moviesSize += file.size;
                    break;
                default:
                    otherSize += file.size;
                    break;
            }
        }

        return "music " + musicSize + "b" +
                "\nimages " + imagesSize + "b" +
                "\nmovies " + moviesSize + "b" +
                "\nother " + otherSize + "b";
    }

    private static File parseToFile(String text) {
        String extension = text.substring(text.lastIndexOf(".") + 1, text.lastIndexOf(" "));
        int size = Integer.parseInt(text.substring(text.lastIndexOf(" ") + 1, text.lastIndexOf("b")));
        if (musicExtensions.contains(extension)) {
            return new File("music", size);
        } else if (imageExtensions.contains(extension)) {
            return new File("images", size);
        } else if (movieExtensions.contains(extension)) {
            return new File("movies", size);
        } else {
            return new File("other", size);
        }
    }
}

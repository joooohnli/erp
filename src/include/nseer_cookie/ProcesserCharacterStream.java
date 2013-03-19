package include.nseer_cookie;

import java.io.*;
public class ProcesserCharacterStream
{
    public static void main(String[] args)
            throws FileNotFoundException, IOException
    {
        String lineStr;
        FileInputStream fileInStream;
        InputStreamReader inputReader;
        BufferedReader bufReader;
        FileOutputStream fileOutStream;
        OutputStreamWriter outputWriter;
        BufferedWriter bufWriter;
        fileInStream = new FileInputStream("d:\\secondFile.txt");
        inputReader = new InputStreamReader(fileInStream);
        bufReader = new BufferedReader(inputReader);
        System.out.println("------------------------------------------------");
        System.out.println("There are file content before modify:");
        while ((lineStr = bufReader.readLine()) != null)
            System.out.println(lineStr);
        bufReader.close();
        inputReader.close();
        fileInStream.close();
        fileOutStream = new FileOutputStream("d:\\secondFile.txt");
        outputWriter = new OutputStreamWriter(fileOutStream);
        bufWriter = new BufferedWriter(outputWriter);
        String newStr = new String("Modify the file ! \r\nThis is a nice thing. \r\nWe can write anything.");
        bufWriter.write(newStr, 0, newStr.length());
        System.out.println(newStr);
        bufWriter.close();
        outputWriter.close();
        fileOutStream.close();
        fileInStream = new FileInputStream("d:\\secondFile.txt");
        inputReader = new InputStreamReader(fileInStream);
        bufReader = new BufferedReader(inputReader);
        System.out.println("------------------------------------------------");
        System.out.println("There are file content after modify:");
        while ((lineStr = bufReader.readLine()) != null)
            System.out.println(lineStr);
        bufReader.close();
        inputReader.close();
        fileInStream.close();
    }
}


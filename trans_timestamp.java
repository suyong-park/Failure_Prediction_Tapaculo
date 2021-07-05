package com.company;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;
import java.util.regex.Pattern;

public class trans_timestamp {

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        String input;
        String[] values;

        input = scanner.nextLine();
        values = input.split("-");

        Validation valid = new Validation(input, values);

        valid.format_Validation();
        valid.length_Validation();
        valid.content_Validation();
        valid.time_Validation();

        String time = values[0] + "-" + values[1] + "-" + values[2] + " " + values[3] + ":" + values[4] + ":" + values[5] + ".0";

        try {
            Timestamp timestamp = Timestamp.valueOf(time);
            System.out.println(timestamp.getTime()/1000);
        } catch (IllegalArgumentException e) {
            System.out.println("TIMESTAMP FORMAT ERROR");
        }
    }
}

class Validation {

    String[] input_array;
    String input_value;

    Validation(String input, String[] time_array) {
        input_value = input;
        input_array = time_array;
    }

    public boolean length_Validation() {

        if(input_array.length != 6) {
            System.out.println("LENGTH ERROR");
            System.exit(1);
            return false;
        }

        return true;
    }

    public boolean format_Validation() {

        for(String temp : input_array) {
            boolean is_valid = Pattern.matches("^[0-9]*$", temp);
            if(!is_valid) {
                System.out.println("FORMAT ERROR");
                System.exit(1);
                return false;
            }
        }

        return true;
    }

    public boolean content_Validation() {

        for(String temp : input_array) {
            if(temp.length() > 5 || temp.length() <= 1) {
                System.out.println("CONTENT ERROR");
                System.exit(1);
                return false;
            }
        }

        return true;
    }

    public boolean time_Validation() {
        SimpleDateFormat time_format = new SimpleDateFormat ( "yyyy-MM-dd-HH-mm-ss");

        Date current_time = new Date();
        Date input_time = null;
        try {
            input_time = time_format.parse(input_value);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        if(input_time.after(current_time)) {
            System.out.println("TIME FORMAT ERROR");
            System.exit(1);
            return false;
        }

        return true;
    }
}

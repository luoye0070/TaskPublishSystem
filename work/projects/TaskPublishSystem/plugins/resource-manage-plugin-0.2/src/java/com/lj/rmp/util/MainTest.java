package com.lj.rmp.util;

import com.lj.rmp.util.media.ConverToFlv;
import com.lj.rmp.util.system.OSinfo;

public class MainTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println( System.getProperty("os.name") );  
	    System.out.println( System.getProperty("os.version") );  
	    System.out.println( System.getProperty("os.arch") ); 
	    System.out.println( OSinfo.getOSname() ); 
	    System.out.println( "OSinfo.is64B()->"+OSinfo.is64B() +",OSinfo.is32B()"+OSinfo.is32B());
//	    ConverToFlv ctf=new ConverToFlv("/Users/c5217839/mywork/springabout/","FfmpegTest/张靓颖-微笑以后.mpg");
//	    ctf.conver();
	    ConverToFlv ctf=new ConverToFlv("","/Users/c5217839/mywork/springabout/","FfmpegTest/张靓颖-微笑以后.flv");
	    System.out.println(ctf.processImg());
	}

}

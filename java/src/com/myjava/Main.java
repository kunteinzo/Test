package com.myjava;

import com.google.gson.Gson;

class Main {

	public static void main(String[] args) {
		System.out.println("Hello world");
		System.out.println(new Gson().toJson(new String[] {"hi", "hello"}));
	}

}
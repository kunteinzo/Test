package org.example

import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.util.Base64

fun main(args: Array<String>) {
    if (args.filter {it.contains("-f") or it.contains("-o")}.isEmpty()) {
        println("Files are required (input/output)")
        System.exit(0)
    }
    try {
        val f1 = File(args[args.indexOf("-f")+1])
        val f2 = File(args[args.indexOf("-o")+1])
        if (f1.exists().not()) {
            println("Input file is missing")
            System.exit(0)
        }
        val fis = FileInputStream(f1)
        val fos = FileOutputStream(f2)
        var buff = ByteArray(1024)
        var len: Int
        while (fis.read(buff).also { len = it } != -1){
            fos.write(buff, 0, len)
        }
        fis.close()
        fos.close()
    } catch (e: Exception) {
        println(e.message)
        System.exit(0)
    }
    /*
    val f = File("a.jar")
    val fis = FileInputStream(f)
    val fos = FileOutputStream(File("b.jar"))
    val buff = ByteArray(1024)
    var byt : Int
    while ( fis.read(buff).also { byt = it } != -1) {
        //println("Chuck: "+buff.decodeToString())
        //println("Size: "+byt)
        fos.write(buff)
    }
    fis.close()
    fos.close()
    */
}
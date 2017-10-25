package org.ranji.lemon.model.liquid.database;

import java.util.Hashtable;

public class ProgressSingleton {
	//为了防止多用户并发，使用线程安全的Hashtable  
    private static Hashtable<Object, Object> table = new Hashtable<>();  
      
    public static void put(Object key, Object value){  
        table.put(key, value);  
    }  
      
    public static Object get(Object key){  
        return table.get(key);  
    }  
      
    public static Object remove(Object key){  
        return table.remove(key);  
    }  
}

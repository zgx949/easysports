package com.ruoyi.system.utls;
import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @program: Ruoyi-Vue
 * @description: 操作word
 * @author: LeftHand
 * @create: 2022-09-15 20:43
 **/
public class WordUtils {
    private static Configuration configuration = null;

    private WordUtils() {
        throw new AssertionError();
    }

    /**
     * 根据模板生成相应的文件
     * @param root 保存数据的map
     * @param template 模板文件的地址
     * @param path 生成的word文档输出地址
     * @return
     */
    public static synchronized ByteArrayOutputStream process(Map<?, ?> root, String template) {

        if (null == root ) {
            throw new RuntimeException("数据不能为空");
        }

        if (null == template) {
            throw new RuntimeException("模板文件不能为空");
        }

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        String templatePath = template.substring(0, template.lastIndexOf("/"));
        String templateName = template.substring(template.lastIndexOf("/") + 1, template.length());

        if (null == configuration) {
            configuration = new Configuration(Configuration.VERSION_2_3_23);  // 这里Configurantion对象不能有两个，否则多线程访问会报错
            configuration.setDefaultEncoding("utf-8");
            configuration.setClassicCompatible(true);
        }
        configuration.setClassForTemplateLoading(WordUtils.class, templatePath);

        Template t = null;
        try {
            t = configuration.getTemplate(templateName);
            Writer w = new BufferedWriter(new OutputStreamWriter(outputStream, "utf-8"));
            t.process(root, w);  // 这里w是一个输出地址，可以输出到任何位置，如控制台，网页等
            w.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return outputStream;
    }

    /**
    * @Description: 生成一行用户的报名信息
    * @Param:
    * @return:
    * @Author: zgx
    * @Date: 2022-09-15
    */
    public static String userRegisterGeneration() {

        return "";
    }
    public static String deptTable (String deptName, String leader, String trainer, List<String> ls) {
        HashMap<String, Object> mp = new HashMap<>();
        mp.put("deptName", deptName);
        mp.put("leader", leader);
        mp.put("trainer", trainer);
        mp.put("rows", ls);
        return WordUtils.process(mp, "/vm/sportMeeting/registerRow.ftl").toString();
    }

    public static void main(String[] args) {
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("depthReport", "部门");
        dataMap.put("gamesOrders", "比赛");
        dataMap.put("gamesGroups", "分组");
        ByteArrayOutputStream outputStream = WordUtils.process(dataMap, "/vm/sportMeeting/template.ftl");
        System.out.println(outputStream.toString());
    }


}

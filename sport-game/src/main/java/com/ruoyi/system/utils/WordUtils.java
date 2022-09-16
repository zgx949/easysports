package com.ruoyi.system.utils;
import com.ruoyi.system.domain.Vo.GameDescVo;
import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.*;
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
    * @Description: 生成多行比赛
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-09-16
    */
    public static String gameList(List<GameDescVo> gamesVo, String itemType) {
        HashMap<String, Object> mp = new HashMap<>();
        mp.put("itemType", itemType);
        int i = 0;
        for (GameDescVo gameDescVo : gamesVo) {
            gameDescVo.setIndex(++i);
        }
        mp.put("games", gamesVo);

        return WordUtils.process(mp, "/vm/sportMeeting/gameGroup.ftl").toString();
    }

    /**
     * @Description: 获取按时间编排的比赛
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-09-16
     */
    public static String gameOrder(String datetime, String typeGroup) {
        HashMap<String, Object> mp = new HashMap<>();
        mp.put("dateTime", datetime);
        mp.put("typeGroup", typeGroup);

        return WordUtils.process(mp, "/vm/sportMeeting/gamesOrderDate.ftl").toString();
    }

    /**
    * @Description: 生成一行用户的报名信息
    * @Param:
    * @return:
    * @Author: zgx
    * @Date: 2022-09-15
    */
    public static String deptTable (String deptName, String leader, String trainer, List<String> ls) {
        HashMap<String, Object> mp = new HashMap<>();
        mp.put("deptName", deptName);
        mp.put("leader", leader);
        mp.put("trainer", trainer);
        mp.put("rows", ls);
        return WordUtils.process(mp, "/vm/sportMeeting/registerRow.ftl").toString();
    }

    /**
     * 方法 1：使用 FileWriter 写文件
     * @param filepath 文件目录
     * @param content  待写入内容
     * @throws IOException
     */
    public static void fileWriterMethod(String filepath, String content) throws IOException {
        try (FileWriter fileWriter = new FileWriter(filepath)) {
            fileWriter.append(content);
        }
    }


}

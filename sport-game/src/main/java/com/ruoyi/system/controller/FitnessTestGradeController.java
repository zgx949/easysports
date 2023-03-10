package com.ruoyi.system.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import cn.hutool.crypto.digest.MD5;
import com.ruoyi.common.annotation.DelPassCache;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.sign.Md5Utils;
import com.ruoyi.system.domain.FitnessTestBaseInfo;
import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.domain.Vo.FitnessBaseInfoVo;
import com.ruoyi.system.domain.Vo.FitnessPassStatusVo;
import com.ruoyi.system.domain.Vo.InsertFitnessTestGradeVo;
import com.ruoyi.system.service.IFitnessTestBaseInfoService;
import com.ruoyi.system.service.IFitnessTestScoreService;
import com.ruoyi.system.service.ISysUserService;
import org.apache.tomcat.util.security.MD5Encoder;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.FitnessTestGrade;
import com.ruoyi.system.service.IFitnessTestGradeService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * ????????????Controller
 *
 * @author leftHand
 * @date 2022-08-23
 */
@RestController
@RequestMapping("/system/grade")
public class FitnessTestGradeController extends BaseController
{
    @Autowired
    private IFitnessTestGradeService fitnessTestGradeService;

    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private IFitnessTestBaseInfoService fitnessTestBaseInfoService;

    @Autowired
    private IFitnessTestScoreService fitnessTestScoreService;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private RabbitTemplate rabbitTemplate;
    /**
     * ????????????????????????
     */
    @PreAuthorize("@ss.hasPermi('system:grade:list')")
    @GetMapping("/list")
    public TableDataInfo list(FitnessTestGrade fitnessTestGrade)
    {
        startPage();
        List<FitnessTestGrade> list = fitnessTestGradeService.selectFitnessTestGradeList(fitnessTestGrade);
        return getDataTable(list);
    }

    /**
     * ????????????????????????
     */
    @PreAuthorize("@ss.hasPermi('system:grade:export')")
    @Log(title = "????????????", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FitnessTestGrade fitnessTestGrade)
    {
        List<FitnessTestGrade> list = fitnessTestGradeService.selectFitnessTestGradeList(fitnessTestGrade);
        ExcelUtil<FitnessTestGrade> util = new ExcelUtil<FitnessTestGrade>(FitnessTestGrade.class);
        util.exportExcel(response, list, "??????????????????");
    }

    /**
     * ??????????????????????????????
     */
    @PreAuthorize("@ss.hasPermi('system:grade:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(fitnessTestGradeService.selectFitnessTestGradeById(id));
    }

    /**
     * ??????????????????
     */
    @PreAuthorize("@ss.hasPermi('system:grade:add')")
    @Log(title = "????????????", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FitnessTestGrade fitnessTestGrade)
    {
        return toAjax(fitnessTestGradeService.insertFitnessTestGrade(fitnessTestGrade));
    }

    /**
     * ??????????????????
     */
    @PreAuthorize("@ss.hasPermi('system:grade:edit')")
    @Log(title = "????????????", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FitnessTestGrade fitnessTestGrade)
    {
        return toAjax(fitnessTestGradeService.updateFitnessTestGrade(fitnessTestGrade));
    }

    /**
     * ??????????????????
     */
    @PreAuthorize("@ss.hasPermi('system:grade:remove')")
    @Log(title = "????????????", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(fitnessTestGradeService.deleteFitnessTestGradeByIds(ids));
    }


    /**
    * ??????????????????
    * */
    @PreAuthorize("@ss.hasPermi('system:grade:list')")
    @RequestMapping("/record")
    public AjaxResult queryMyTest() {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        if (user != null) {
            return AjaxResult.success(fitnessTestGradeService.queryMyRecord(user));
        } else {
            return AjaxResult.error("????????????");
        }
    }

    /**
     * ???????????????????????????????????????
     */
    @PostMapping("/sysUserListByNames")
   /* public AjaxResult selectSysUserListByNames(@RequestBody List<String>userNameList){
       return AjaxResult.success(fitnessTestGradeService.selectSysUserListByNames(userNameList));
    }*/
    public AjaxResult selectBaseInfoByUserIds(@RequestBody List<String> userIds){
        if(CollectionUtils.isEmpty(userIds)){
            return AjaxResult.success("??????????????????",userIds);
        }
        List<FitnessTestBaseInfo> fitnessTestBaseInfos = fitnessTestBaseInfoService.selectBaseInfoByUserIds(userIds);
        if(fitnessTestBaseInfos.size()==userIds.size()){
            return AjaxResult.success("????????????????????????",fitnessTestBaseInfos);
        }else {
            return AjaxResult.success("??????"+fitnessTestBaseInfos.size()+"?????????,????????????????????????",fitnessTestBaseInfos);
        }
    }

    /**
     * ??????????????????
     */
    @Log(title = "????????????", businessType = BusinessType.INSERT)
    @DelPassCache // ?????????????????????????????????
    @PostMapping("/insertGradeList")
    public AjaxResult insertGradeList(@RequestBody List<FitnessTestScore>fitnessTestScores){
        rabbitTemplate.convertAndSend("topicExchange", fitnessTestScores);
        return AjaxResult.success("????????????");
//        int successCount = fitnessTestScoreService.insertFitnessTestScoreList(fitnessTestScores);
//        if(successCount!=fitnessTestScores.size()){
//            return AjaxResult.success("???????????????????????????????????????",successCount);
//        }
//        return AjaxResult.success("????????????????????????",successCount);
    }
    /**
     * ????????????????????????
     */
    @GetMapping("/pass")
    public AjaxResult queryPass(String userId){
        // ?????????userid?????????
        if (StringUtils.isEmpty(userId)) {
            return AjaxResult.error("??????????????????");
        }
        userId = userId.trim();
        if (userId.length() != 7) {
            return AjaxResult.error("???????????????7???");
        }

        String key = "fitness:pass:" + userId;
        FitnessPassStatusVo result = redisCache.getCacheObject(key);
        // ???????????????
        if (result == null) {
            result = fitnessTestGradeService.queryPass(userId);
            // ???????????????
            redisCache.setCacheObject(key, result, 10, TimeUnit.MINUTES);
            // ????????????????????????????????????
            rabbitTemplate.convertAndSend("cacheClass", result.getUserInfo());
        }

        return AjaxResult.success("????????????", result);
    }

}

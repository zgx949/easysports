package com.ruoyi.system.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.annotation.DelPassCache;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.FitnessTestBaseInfo;
import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.domain.Vo.FitnessPassStatusVo;
import com.ruoyi.system.domain.Vo.InsertFitnessTestGradeVo;
import com.ruoyi.system.service.IFitnessTestBaseInfoService;
import com.ruoyi.system.service.IFitnessTestScoreService;
import com.ruoyi.system.service.ISysUserService;
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
 * 体测成绩Controller
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

    /**
     * 查询体测成绩列表
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
     * 导出体测成绩列表
     */
    @PreAuthorize("@ss.hasPermi('system:grade:export')")
    @Log(title = "体测成绩", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FitnessTestGrade fitnessTestGrade)
    {
        List<FitnessTestGrade> list = fitnessTestGradeService.selectFitnessTestGradeList(fitnessTestGrade);
        ExcelUtil<FitnessTestGrade> util = new ExcelUtil<FitnessTestGrade>(FitnessTestGrade.class);
        util.exportExcel(response, list, "体测成绩数据");
    }

    /**
     * 获取体测成绩详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:grade:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(fitnessTestGradeService.selectFitnessTestGradeById(id));
    }

    /**
     * 新增体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:grade:add')")
    @Log(title = "体测成绩", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FitnessTestGrade fitnessTestGrade)
    {
        return toAjax(fitnessTestGradeService.insertFitnessTestGrade(fitnessTestGrade));
    }

    /**
     * 修改体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:grade:edit')")
    @Log(title = "体测成绩", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FitnessTestGrade fitnessTestGrade)
    {
        return toAjax(fitnessTestGradeService.updateFitnessTestGrade(fitnessTestGrade));
    }

    /**
     * 删除体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:grade:remove')")
    @Log(title = "体测成绩", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(fitnessTestGradeService.deleteFitnessTestGradeByIds(ids));
    }


    /**
    * 查询个人成绩
    * */
    @PreAuthorize("@ss.hasPermi('system:grade:list')")
    @RequestMapping("/record")
    public AjaxResult queryMyTest() {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        if (user != null) {
            return AjaxResult.success(fitnessTestGradeService.queryMyRecord(user));
        } else {
            return AjaxResult.error("非法用户");
        }
    }

    /**
     * 根据用户名列表查询用户信息
     */
    @PostMapping("/sysUserListByNames")
   /* public AjaxResult selectSysUserListByNames(@RequestBody List<String>userNameList){
       return AjaxResult.success(fitnessTestGradeService.selectSysUserListByNames(userNameList));
    }*/
    public AjaxResult selectBaseInfoByUserIds(@RequestBody List<String> userIds){
        if(CollectionUtils.isEmpty(userIds)){
            return AjaxResult.success("学号集合为空",userIds);
        }
        List<FitnessTestBaseInfo> fitnessTestBaseInfos = fitnessTestBaseInfoService.selectBaseInfoByUserIds(userIds);
        if(fitnessTestBaseInfos.size()==userIds.size()){
            return AjaxResult.success("全部信息查询成功",fitnessTestBaseInfos);
        }else {
            return AjaxResult.success("查出"+fitnessTestBaseInfos.size()+"条数据,与传入学号数不符",fitnessTestBaseInfos);
        }
    }

    /**
     * 批量录入成绩
     */
    @Log(title = "体测成绩", businessType = BusinessType.INSERT)
    @DelPassCache // 自动删除成绩信息的缓存
    @PostMapping("/insertGradeList")
    public AjaxResult insertGradeList(@RequestBody List<FitnessTestScore>fitnessTestScores){
        int successCount = fitnessTestScoreService.insertFitnessTestScoreList(fitnessTestScores);
        if(successCount!=fitnessTestScores.size()){
            return AjaxResult.success("录入成绩数与传入成绩数不符",successCount);
        }
        return AjaxResult.success("全部成绩录入成功",successCount);
    }
    /**
     * 查询成绩合格情况
     */
    @GetMapping("/pass")
    public AjaxResult queryPass(String userId){
        // 这里的userid是学号
        if (StringUtils.isEmpty(userId)) {
            return AjaxResult.error("学号不得为空");
        }
        userId = userId.trim();
        if (userId.length() != 7) {
            return AjaxResult.error("学号必须是7位");
        }

        String key = "fitness:pass:" + userId;
        FitnessPassStatusVo result = redisCache.getCacheObject(key);
        // 不存在缓存
        if (result == null) {
            result = fitnessTestGradeService.queryPass(userId);
            // 缓存十分钟
            redisCache.setCacheObject(key, result, 10, TimeUnit.MINUTES);
        }

        return AjaxResult.success("查询成功", result);
    }

}

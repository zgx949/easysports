package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.ruoyi.system.domain.SportFeedback;
import com.ruoyi.system.service.ISportFeedbackService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 反馈Controller
 * 
 * @author lsq
 * @date 2022-10-10
 */
@RestController
@RequestMapping("/system/feedback")
public class SportFeedbackController extends BaseController
{
    @Autowired
    private ISportFeedbackService sportFeedbackService;

    /**
     * 查询反馈列表
     */
    @PreAuthorize("@ss.hasPermi('system:feedback:list')")
    @GetMapping("/list")
    public TableDataInfo list(SportFeedback sportFeedback)
    {
        startPage();
        List<SportFeedback> list = sportFeedbackService.selectSportFeedbackList(sportFeedback);
        return getDataTable(list);
    }

    /**
     * 导出反馈列表
     */
    @PreAuthorize("@ss.hasPermi('system:feedback:export')")
    @Log(title = "反馈", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SportFeedback sportFeedback)
    {
        List<SportFeedback> list = sportFeedbackService.selectSportFeedbackList(sportFeedback);
        ExcelUtil<SportFeedback> util = new ExcelUtil<SportFeedback>(SportFeedback.class);
        util.exportExcel(response, list, "反馈数据");
    }

    /**
     * 获取反馈详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:feedback:query')")
    @GetMapping(value = "/{feedbackId}")
    public AjaxResult getInfo(@PathVariable("feedbackId") Long feedbackId)
    {
        return AjaxResult.success(sportFeedbackService.selectSportFeedbackByFeedbackId(feedbackId));
    }

    /**
     * 新增反馈
     */
    @PreAuthorize("@ss.hasPermi('system:feedback:add')")
    @Log(title = "反馈", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportFeedback sportFeedback)
    {
        return toAjax(sportFeedbackService.insertSportFeedback(sportFeedback));
    }

    /**
     * 修改反馈
     */
    @PreAuthorize("@ss.hasPermi('system:feedback:edit')")
    @Log(title = "反馈", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportFeedback sportFeedback)
    {
        return toAjax(sportFeedbackService.updateSportFeedback(sportFeedback));
    }

    /**
     * 删除反馈
     */
    @PreAuthorize("@ss.hasPermi('system:feedback:remove')")
    @Log(title = "反馈", businessType = BusinessType.DELETE)
	@DeleteMapping("/{feedbackIds}")
    public AjaxResult remove(@PathVariable Long[] feedbackIds)
    {
        return toAjax(sportFeedbackService.deleteSportFeedbackByFeedbackIds(feedbackIds));
    }

    /**
     * 根据反馈ID查询反馈
     */
    @GetMapping("/user/{feedbackId}")
    public AjaxResult selectFeedbackById(@PathVariable("feedbackId")Long feedbackId){
        return AjaxResult.success(sportFeedbackService.selectSportFeedbackByFeedbackId(feedbackId));
    }

    /**
     * 分页查询用户的所有反馈记录
     */
    @GetMapping("/user/list")
    public TableDataInfo selectUserFeedbacks(){
        SportFeedback sportFeedback=new SportFeedback();
        sportFeedback.setUserId(SecurityUtils.getUserId());
        startPage();
        List<SportFeedback> sportFeedbacks=sportFeedbackService.selectSportFeedbackList(sportFeedback);
        return getDataTable(sportFeedbacks);
    }

    /**
     * 用户新增一条反馈记录
     */
    @PostMapping("/user")
    public AjaxResult inserUserFeedback(@RequestBody SportFeedback sportFeedback){
        int insertIndex=sportFeedbackService.insertUserFeedback(sportFeedback);
        return insertIndex==0?AjaxResult.error("字数不符合要求"):toAjax(insertIndex);
    }

    /**
     * 用户修改一条反馈记录
     */
    @PutMapping("/user")
    public AjaxResult updateUserFeedback(@RequestBody SportFeedback sportFeedback){
        int updateIndex=sportFeedbackService.updateUserFeedback(sportFeedback);
        return updateIndex==0?AjaxResult.error("字数不符合要求或已不允许修改"):toAjax(updateIndex);
    }

    /**
     * 用户删除一条反馈记录
     */
    @DeleteMapping("/user/{feedbackId}")
    public AjaxResult deleteUserFeedback(@PathVariable("feedbackId")Long feedbackId){
        return toAjax(sportFeedbackService.deleteSportFeedbackByFeedbackId(feedbackId));
    }

    /**
     * 将一条反馈标记为已查看
     */
    @GetMapping("/check/{feedbackId}")
    public AjaxResult checkUserFeedback(@PathVariable("feedbackId")Long feedbackId){
        return toAjax(sportFeedbackService.checkUserFeedback(feedbackId));
    }
}

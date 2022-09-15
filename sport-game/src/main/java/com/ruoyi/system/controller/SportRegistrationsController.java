package com.ruoyi.system.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.SportFields;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.Vo.GameSequenceBookVO;
import com.ruoyi.system.domain.dto.UpdateGamesScoreDto;
import com.ruoyi.system.service.ISportFieldsService;
import com.ruoyi.system.service.ISportGamesService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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
import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.service.ISportRegistrationsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 报名管理Controller
 *
 * @author leftHand
 * @date 2022-07-06
 */
@RestController
@Api
@RequestMapping("/system/registrations")
public class SportRegistrationsController extends BaseController
{
    @Autowired
    private ISportRegistrationsService sportRegistrationsService;

    @Autowired
    private ISportGamesService sportGamesService;

    @Autowired
    private ISportFieldsService sportFieldsService;

    /**
     * 新增报名管理
     */
    @Log(title = "用户报名", businessType = BusinessType.INSERT)
    @PostMapping("/register")
    public AjaxResult register(@RequestBody Map<String, String> sportRegistrations)
    {
        return toAjax(sportRegistrationsService.userInsertSportRegistrations(sportRegistrations));
    }

    /**
     * 查询报名管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:list')")
    @GetMapping("/list")
    public TableDataInfo list(SportRegistrations sportRegistrations)
    {
        // 如果传递的积分参数为0（前端默认传0，不是null，所以会导致查询数据丢失）
        Long points = sportRegistrations.getPoints();
        if (points == null || points.equals(0L)) {
            sportRegistrations.setPoints(null);
        }
        startPage();
        List<SportRegistrations> list = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        return getDataTable(list);
    }

    /**
     * 导出报名管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:export')")
    @Log(title = "报名管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SportRegistrations sportRegistrations)
    {
        List<SportRegistrations> list = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        ExcelUtil<SportRegistrations> util = new ExcelUtil<SportRegistrations>(SportRegistrations.class);
        util.exportExcel(response, list, "报名管理数据");
    }

    /**
     * 获取报名管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(sportRegistrationsService.selectSportRegistrationsById(id));
    }

    /**
     * 新增报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:add')")
    @Log(title = "报名管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportRegistrations sportRegistrations)
    {
        return toAjax(sportRegistrationsService.insertSportRegistrations(sportRegistrations));
    }

    /**
     * 修改报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:edit')")
    @Log(title = "报名管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportRegistrations sportRegistrations)
    {
        return toAjax(sportRegistrationsService.updateSportRegistrations(sportRegistrations));
    }

    /**
     * 删除报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:remove')")
    @Log(title = "报名管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sportRegistrationsService.deleteSportRegistrationsByIds(ids));
    }

    /**
     * 根据用户id查询报名比赛
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:list')")
    @ApiOperation("根据用户id查询报名比赛")
    @GetMapping("/user/list")
    public TableDataInfo userRegisterationslist(SportRegistrations sportRegistrations)
    {
        sportRegistrations.setUserId(SecurityUtils.getUserId());
        List<SportRegistrations> sportRegistrationsList= sportRegistrationsService.userRegisterationslist(sportRegistrations);
        startPage();
        return getDataTable(sportRegistrationsList);
    }

    /**
     * 根据比赛id和用户id查询成绩
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:query')")
    @GetMapping("/user/{gameId}")
    public AjaxResult userScore(@PathVariable("gameId") Long gameId)
    {
        SportRegistrations sportRegistrations=new SportRegistrations();
        sportRegistrations.setGameId(gameId);
        sportRegistrations.setUserId(SecurityUtils.getUserId());
        List<SportRegistrations> sportRegistrationsList= sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        if(sportRegistrationsList.size()!=1){
            return AjaxResult.error();
        }
        return AjaxResult.success(sportRegistrationsList.get(0));
    }

    /**
     * 用户报名比赛
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:add')")
    @PostMapping("/user/{gameId}")
    public AjaxResult insertUserRegistrations(SportRegistrations sportRegistrations)
    {
        sportRegistrations.setUserId(SecurityUtils.getUserId());
        sportRegistrations.setUpdateTime(DateUtils.getNowDate());
        sportRegistrations.setCreateTime(DateUtils.getNowDate());

        return toAjax(sportRegistrationsService.insertUserRegistrations(sportRegistrations));
    }

    /**
     * 用户取消报名
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:remove')")
    @DeleteMapping("/user/{gameId}")
    public AjaxResult deleteUserRegistrations(@PathVariable("gameId") Long gameId)
    {
        return toAjax(sportRegistrationsService.deleteUserRegistrations(SecurityUtils.getUserId(),gameId));
    }


    @PreAuthorize("@ss.hasPermi('system:registrations:edit')")
    @ApiOperation("管理员录入成绩")
    @PutMapping("update/score")
    public AjaxResult updateGamesScore(@RequestBody UpdateGamesScoreDto updateGamesScoreDto)
    {
        if ( ! SecurityUtils.getLoginUser().getUser().isAdmin()){
            throw new ServiceException("无此权限");
        }
        if (sportRegistrationsService.handleUpdateScore(updateGamesScoreDto)){
            return AjaxResult.success();
        }
        return AjaxResult.error("录入成绩失败");
    }


    /**
     * 获取生成秩序册所需必要信息
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:query')")
    @GetMapping()
    @ApiOperation("获取生成秩序册所需必要信息")
    public AjaxResult getInf()
    {
        List<GameSequenceBookVO> gameSequenceBookVOS = sportRegistrationsService.exportGameSequenceBookVo();
        return AjaxResult.success(gameSequenceBookVOS);
    }
}

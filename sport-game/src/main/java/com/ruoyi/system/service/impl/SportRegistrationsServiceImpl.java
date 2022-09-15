package com.ruoyi.system.service.impl;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;

import java.util.ArrayList;
import java.util.Date;

import java.util.List;
import java.util.Map;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.Vo.GameSequenceBookVO;
import com.ruoyi.system.domain.Vo.GameSequenceItemVO;
import com.ruoyi.system.domain.dto.UpdateGamesScoreDto;
import com.ruoyi.system.domain.vo.CollegeVo;
import com.ruoyi.system.mapper.SysDeptMapper;
import com.ruoyi.system.service.ISysDeptService;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportRegistrationsMapper;
import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.service.ISportRegistrationsService;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;

/**
 * 报名管理Service业务层处理
 *
 * @author leftHand
 * @date 2022-07-05
 */
@Service
public class SportRegistrationsServiceImpl implements ISportRegistrationsService
{
    @Autowired
    private SportRegistrationsMapper sportRegistrationsMapper;

    @Autowired
    private RedisCache redisCache;

    @Resource
    private ISysDeptService sysDeptService;
    /**
     * 用户报名项目
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int userInsertSportRegistrations(Map<String, String> sportRegistrations) {
        // TODO:用户报名项目
        // 学号
        Long idcard = Long.valueOf(sportRegistrations.get("idcard"));
        // 姓名
        String name = sportRegistrations.get("name");
        // 比赛ID
        Long gameId = Long.valueOf(sportRegistrations.get("gameId"));
        // 密码
        String passwd = sportRegistrations.get("password");

        return 0;
    }

    /**
     * 查询报名管理
     *
     * @param id 报名管理主键
     * @return 报名管理
     */
    @Override
    public SportRegistrations selectSportRegistrationsById(Long id)
    {
        return sportRegistrationsMapper.selectSportRegistrationsById(id);
    }

    /**
     * 查询报名管理列表
     *
     * @param sportRegistrations 报名管理
     * @return 报名管理
     */
    @Override
    public List<SportRegistrations> selectSportRegistrationsList(SportRegistrations sportRegistrations)
    {
        return sportRegistrationsMapper.selectSportRegistrationsList(sportRegistrations);
    }

    /**
     * 新增报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int insertSportRegistrations(SportRegistrations sportRegistrations)
    {
        sportRegistrations.setCreateTime(DateUtils.getNowDate());
        return sportRegistrationsMapper.insertSportRegistrations(sportRegistrations);
    }

    /**
     * 修改报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int updateSportRegistrations(SportRegistrations sportRegistrations)
    {
        sportRegistrations.setUpdateTime(DateUtils.getNowDate());
        return sportRegistrationsMapper.updateSportRegistrations(sportRegistrations);
    }

    /**
     * 批量删除报名管理
     *
     * @param ids 需要删除的报名管理主键
     * @return 结果
     */
    @Override
    public int deleteSportRegistrationsByIds(Long[] ids)
    {
        return sportRegistrationsMapper.deleteSportRegistrationsByIds(ids);
    }

    /**
     * 删除报名管理信息
     *
     * @param id 报名管理主键
     * @return 结果
     */
    @Override
    public int deleteSportRegistrationsById(Long id)
    {
        return sportRegistrationsMapper.deleteSportRegistrationsById(id);
    }

    /**
     * 根据用户id和比赛id取消报名
     * @param userId
     * @param gameId
     * @return
     */
    @Override
    public int deleteUserRegistrations(Long userId, Long gameId) {
        return sportRegistrationsMapper.deleteUserSportRegistrations(userId,gameId);
    }

    /**
     * 根据用户id查询比赛信息并排序
     * @param sportRegistrations
     * @return
     */
    @Override
    public List<SportRegistrations> userRegisterationslist(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.userRegisterationslist(sportRegistrations);
    }

    /**
     * 用户报名
     * @param sportRegistrations
     * @return
     */
    @Override
    public int insertUserRegistrations(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.insertUserRegistrations(sportRegistrations);
    }

    /**
     * @Description 处理更新成绩请求(删除对应成绩排名表缓存)
     * @Param updateGamesScoreDto
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/13 13:18
     */
    @Override
    public boolean handleUpdateScore(UpdateGamesScoreDto updateGamesScoreDto) {

        if (!ObjectUtils.allNotNull(updateGamesScoreDto,updateGamesScoreDto.getScore(),updateGamesScoreDto.getGameId()
                ,updateGamesScoreDto.getPoints(),updateGamesScoreDto.getUserId())){
            throw new ServiceException("请输入完整数据");
        }

        if (StringUtils.isNoneBlank(updateGamesScoreDto.getComment()) && updateGamesScoreDto.getComment().length() > 255){
            throw new ServiceException("备注信息过长");
        }

        if(updateGamesScoreDto.getScore() < 0 || updateGamesScoreDto.getPoints() < 0){
            throw new ServiceException("成绩积分不能为负数");
        }

        //TODO 审核信息安全

        SportRegistrations sportRegistrations = new SportRegistrations();
        sportRegistrations.setGameId(updateGamesScoreDto.getGameId());
        sportRegistrations.setUserId(updateGamesScoreDto.getUserId());
        sportRegistrations.setScore(updateGamesScoreDto.getScore());
        sportRegistrations.setPoints(updateGamesScoreDto.getPoints());
        sportRegistrations.setComment(updateGamesScoreDto.getComment());
        sportRegistrations.setUpdateTime(new Date());

        // 删除gameId对应比赛的排名表缓存
        redisCache.deleteObject("sport:game:result:" + updateGamesScoreDto.getGameId());

        return sportRegistrationsMapper.updateSportScoreData(sportRegistrations);
    }

    /**
     * @return
     * @Description 获取生成秩序册所需必要信息
     * @Param
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/15 12:01
     */
    @Override
    public List<GameSequenceBookVO> exportGameSequenceBookVo() {
        //TODO
        //定义结果集
        ArrayList<GameSequenceBookVO> gameSequenceBookVOS = new ArrayList<>();

        List<CollegeVo> collegeVos = sysDeptService.selectCollegeList(new SysDept());

        for (CollegeVo collegeVo :collegeVos) {
            //mock 假数据
            GameSequenceBookVO gameSequenceBookVO = new GameSequenceBookVO();
            gameSequenceBookVO.setCoach("廖家栋");
            gameSequenceBookVO.setLeader("吕镇坤");
            gameSequenceBookVO.setPhoneNumber("18507093323");
            //设置学院
            gameSequenceBookVO.setDeptName(collegeVo.getDeptName());
            //根据学院查询秩序册信息
            ArrayList<GameSequenceItemVO> gameSequenceItemVOs = this.getGameSequenceItemVOsByDeptID(collegeVo.getDeptId());
            gameSequenceBookVO.setGameSequenceItem(gameSequenceItemVOs);
            //将数据加入结果集
            gameSequenceBookVOS.add(gameSequenceBookVO);
        }



        return gameSequenceBookVOS;
    }

    private ArrayList<GameSequenceItemVO> getGameSequenceItemVOsByDeptID(Long deptId) {
        if (ObjectUtils.isEmpty(deptId)){
            return null;
        }
        //获取学生数据集合
        ArrayList<GameSequenceItemVO> gameSequenceItemVOs = sportRegistrationsMapper.selectGameSequenceItemVOsByDeptID(deptId);
        for (GameSequenceItemVO gameSequenceItemVO :gameSequenceItemVOs) {
            ArrayList<String> gameSequenceItemGamesName = this.getGameSequenceItemGamesVOsByUserId(gameSequenceItemVO.getUserId());
            //遍历每一条学生数据 给joinGame赋值
            gameSequenceItemVO.setJoinGames(gameSequenceItemGamesName);
        }

        return gameSequenceItemVOs;
    }

    /**
     * @Description 根据学号查询其参加比赛的数据
     * @Param userId
     * @Return {@link ArrayList< String>}
     * @Author coder_jlt
     * @Date 2022/9/15 13:38
     */
    private ArrayList<String> getGameSequenceItemGamesVOsByUserId(Long userId) {
        if (ObjectUtils.isEmpty(userId)){
            return null;
        }
        return sportRegistrationsMapper.getGameSequenceItemGamesName(userId);
    }


}

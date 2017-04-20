<?php
class Ad_model extends CI_Model
{
	function __construct()
	{
		parent::__construct();
	}
    
	
    /**
     * 获取所有数据
     * @author  alan    2016.1.30
     * @param   $id     父ID
     * @return  Array OR false   二维数组或False
     */ 
	function getRecords()
	{
        $this->db->select('t.* ,adcha.channel_name ,adpage.page_name ,adpos.position_name' ,false);
        $this->db->from('ad AS t');
        $this->db->join('ad_channel AS adcha' ,'t.channel_id = adcha.channel_id' ,'left');
        $this->db->join('ad_page AS adpage' ,'t.page_id = adpage.page_id' ,'left');
        $this->db->join('ad_position AS adpos' ,'t.position_id = adpos.position_id' ,'left');
        $this->db->order_by('t.id DESC');
		$query=$this->db->get();
        if($query->num_rows() > 0)
        {
            return $query->result_array();
    		
        }
		return array();
	}
    
    /**
     * 获取一条菜单记录
     * @author  alan    2014.7.21
     * @param   $id     INT     表ID 
     * @return  Array OR false   一维数组或False
     */ 
    function getRecord($id)
	{
		$query = $this->db->get_where('ad',array('id'=>$id));
        if($query->num_rows() > 0)
        {
            return $query->row_array();
        }else
        {
            return array();
        }
	}
    

    /**
     * 添加记录
     * @author  alan    2014.7.21
     * @return  INT    2:用户名存在 ，0:添加失败 ，1:添加成功  
     */ 
    function insertRecord()
	{  
        $data = array(
            'channel_id' => $this->input->post('channel_id'),
            'page_id' => $this->input->post('page_id'),
            'position_id' => $this->input->post('position_id'),
            'width' => $this->input->post('width'),
            'height' => $this->input->post('height'),
            'ad_name' => $this->input->post('ad_name'),
            //'pic_info' => $this->input->post('pic_info'),
            'link' => $this->input->post('link'),
            'target' => $this->input->post('target') ? $this->input->post('target') : 0,
            'end_time' => $this->input->post('end_time'),
        );

        $data = unsetEmptyValueByArray($data); //过滤空值

        $data['end_time'] = strtotime($data['end_time']);//时间转成时间戳
        

		$this->db->insert("ad",$data);
        
		if($this->db->affected_rows())
		{
            $insertId = $this->db->insert_id();
			
            $uploadData = $this->session->userdata('uploadData');
            $imgData = $uploadData['ad'];
            if(!empty($imgData))
            {
                $adImgs = array();
                foreach($imgData as $k => $img)
                {
                    $adImgs[$k]['ad_id'] = $insertId;
                    $adImgs[$k]['pic_path'] = $img;
                }

                $this->db->insert_batch('ad_images' ,$adImgs);
                if($this->db->affected_rows() > 0) //添加成功后，清除图片资料
                {
                    $uploadData['ad'] = array();
                    $this->session->set_userdata('uploadData' ,$uploadData);
                }
            }
            return true;

		}
		else
		{
			return false;
		}
	}
    
    

    /**
     * 更改记录
     * @author  alan    2014.7.22
     * @return  INT    2:用户名存在 ，0:添加失败 ，1:添加成功 
     */
    function updateRecord()
	{
        $id = $this->input->post('id');
        if(empty($id))
        {
            return false;
        }
		$data = array(
            'channel_id' => $this->input->post('channel_id'),
            'page_id' => $this->input->post('page_id'),
            'position_id' => $this->input->post('position_id'),
            'width' => $this->input->post('width'),
            'height' => $this->input->post('height'),
            'ad_name' => $this->input->post('ad_name'),
            'link' => $this->input->post('link'),
            'target' => $this->input->post('target') ? $this->input->post('target') : 0,
            'end_time' => $this->input->post('end_time'),
        );

        $data = unsetEmptyValueByArray($data); //过滤空值

        $data['end_time'] = strtotime($data['end_time']);//时间转成时间戳
		
        $this->db->where('id' ,$id);
        $this->db->update("ad" ,$data);
        $dataRes = $this->db->affected_rows(); //数据修改状态

        $uploadData = $this->session->userdata('uploadData');
        $imgData = isset($uploadData['ad']) ? $uploadData['ad'] : array();
        if(!empty($imgData))
        {
            $adImgs = array();
            foreach($imgData as $k => $img)
            {
                $adImgs[$k]['ad_id'] = $id;
                $adImgs[$k]['pic_path'] = $img;
            }

            $this->db->insert_batch('ad_images' ,$adImgs);

            $imageRes = $this->db->affected_rows();
            //清除图片，不管操作成功还是失败都清除这次缓存的图片内容
            $uploadData['ad'] = array();
            $this->session->set_userdata('uploadData' ,$uploadData);
            
        }
        if($dataRes > 0 || $imgData > 0)
        {
            return true;

        }
        else
        {
            return false;
        }
	}
    

    
    /**
     * 删除记录
     * @author  alan    2014.7.22
     */
    function deleteRecord()
    {
        $ids = $this->input->get('id');

        if(is_array($ids))
        {
            $this->db->where_in('id' ,$ids);
        }else
        {
            $this->db->where('id' ,$ids);
        }
        
        $this->db->delete('ad');
        if($this->db->affected_rows() > 0)
        {
            $this->delImageByAdId($ids);//删除图片数据
            return true;
        }else
        {
            return false;
        }
    }

    /**
     * 根据广告ID删除图片
     * @param  String OR Array $ids id ,或id数组
     * @return Boolean
     */
    public function delImageByAdId($ids)
    {
        //删除图片
        if(is_array($ids))
        {
            $this->db->where_in('ad_id' ,$ids);
        }else
        {
            $this->db->where('ad_id' ,$ids);
        }
        $imagesList = $this->db->get('ad_images')->result_array();
        if(!empty($imagesList))
        {
            foreach($imagesList as $v) //删除图片
            {
                unlink($v['pic_path']);
            }
        }

        if(is_array($ids))
        {
            $this->db->where_in('ad_id' ,$ids);
        }else
        {
            $this->db->where('ad_id' ,$ids);
        }
        $this->db->delete('ad_images');
        return $this->db->affected_rows();
    } 

    /**
     * 删除图片
     * @param  String OR Array $ids id ,或id数组
     * @return Boolean
     */
    public function delImage($ids)
    {
        //删除图片
        if(is_array($ids))
        {
            $this->db->where_in('id' ,$ids);
        }else
        {
            $this->db->where('id' ,$ids);
        }
        $imagesList = $this->db->get('ad_images')->result_array();
        if(!empty($imagesList))
        {
            foreach($imagesList as $v)
            {
                unlink($v['pic_path']);
            }
        }
        if(is_array($ids))
        {
            $this->db->where_in('id' ,$ids);
        }else
        {
            $this->db->where('id' ,$ids);
        }
        $this->db->delete('ad_images');
        return $this->db->affected_rows();
    } 
    
    /**
     * 获得所有频道数据
     * @return Array
     */
    public function getChannelList()
    {
        $query = $this->db->get('ad_channel');
        if($query->num_rows() > 0)
        {
            return $query->result_array();
        }
        return array();
    }


    /**
     * 获得频道页面
     * @return Array
     */
    public function getAdPagelList($channelId='')
    {
        if(!empty($channelId))
        {
            $this->db->where('channel_id' ,$channelId);
        }
        $query = $this->db->get('ad_page');
        if($query->num_rows() > 0)
        {
            return $query->result_array();
        }
        return array();
    }

    /**
     * 获得页面位置
     * @return Array
     */
    public function getAdPositionList($pageId='')
    {
        if(!empty($pageId))
        {
            $this->db->where('page_id' ,$pageId);
        }
        $query = $this->db->get('ad_position');
        if($query->num_rows() > 0)
        {
            return $query->result_array();
        }
        return array();
    }

    /**
     * 获取广告图片
     * @param  string $adId 广告ID
     * @return Array
     */
    public function getAdImages($adId='')
    {
        if(!empty($adId))
        {
            $this->db->where('ad_id' ,$adId);
        }
        $list = $this->db->get('ad_images')->result_array();

        return $list ? $list : array();
    }
}
?>
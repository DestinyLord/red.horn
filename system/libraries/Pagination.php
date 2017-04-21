<?php

if (! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * CodeIgniter
 *
 * An open source application development framework for PHP 5.1.6 or newer
 *
 * @package		CodeIgniter
 * @author		ExpressionEngine Dev Team
 * @copyright	Copyright (c) 2008 - 2011, EllisLab, Inc.
 * @license		http://codeigniter.com/user_guide/license.html
 * @link		http://codeigniter.com
 * @since		Version 1.0
 * @filesource
 */

// ------------------------------------------------------------------------

/**
 * Pagination Class
 *
 * @package		CodeIgniter
 * @subpackage	Libraries
 * @category	Pagination
 * @author		ExpressionEngine Dev Team
 * @link		http://codeigniter.com/user_guide/libraries/pagination.html
 */
class CI_Pagination
{

    var $base_url = ''; // The page we are linking to
    var $url_string = '';
    var $total_rows = 0; // Total number of items (database results)
    var $per_page = 20; // Max number of items you want shown per page
    var $num_links = 5; // Number of "digit" links to show before/after the currently viewed page
    var $cur_page = 0; // The current page being viewed
    var $page_start = 0; //Number of page start
    var $singal_page = false; // Singal page
    var $first_link = '首页';
    var $last_link = '尾页';
    var $next_link = '下一页';
    var $prev_link = '上一页';
    var $page_static = true;
    var $query_string_segment = 'page';
    var $display_pages = true;
    var $url_suffix = '';

    /**
     * Constructor
     *
     * @access	public
     * @param	array	initialization parameters
     */
    public function __construct($params = array())
    {
        if (count($params) > 0) {
            $this->initialize($params);
        }

        log_message('debug', "Pagination Class Initialized");
    }

    // --------------------------------------------------------------------

    /**
     * Initialize Preferences
     *
     * @access	public
     * @param	array	initialization parameters
     * @return	void
     */
    function initialize($params = array())
    {
        if (count($params) > 0) {
            foreach ($params as $key => $val) {
                if (isset($this->$key)) {
                    $this->$key = $val;
                }
            }
        }

        if (strstr($this->base_url, '?')) {
            $urlString = explode('?', $this->base_url);
            $this->base_url = $urlString[0];
            $this->url_string = '?'.$urlString[1];
        }
    }

    // --------------------------------------------------------------------
    /**
     * Generate the pagination links
     *
     * @access	public
     * @return	string
     */
    function create_links()
    {
        // If our item count or per-page total is zero there is no need to continue.
        if ($this->total_rows == 0 or $this->per_page == 0) {
            return '';
        }

        // Calculate the total number of pages
        $num_pages = ceil($this->total_rows / $this->per_page);

        // Is there only one page? Hm... nothing more to do here then.
        if ($num_pages == 1) {
            return '';
        }

        $this->num_links = (int)$this->num_links;

        //if ($this->num_links < 1) {
        //show_error('Your number of links must be a positive number.');
        //}

        if (! is_numeric($this->cur_page)) {
            $this->cur_page = 1;
        }

        if ($this->cur_page > $num_pages) {
            $this->cur_page = $num_pages;
        }

        $this->page_start = $this->per_page * ($this->cur_page - 1);

        // Calculate the start and end numbers. These determine
        // which number to start and end the digit links with
        $start = (($this->cur_page - $this->num_links) > 0)?$this->cur_page - ($this->num_links - 1) : 1;
        $end = (($this->cur_page + $this->num_links) < $num_pages)?$this->cur_page + $this->num_links : $num_pages;

        // And here we go...
        $output = '';
        if ($this->cur_page > 1) {
            //$output .= "<a href=\"".$this->parse_link(1)."\">".$this->first_link."</a>";
            $output .= "<li><a href=\"".$this->parse_link($this->cur_page - 1)."\" aria-label=\"Previous\"><span aria-hidden=\"true\">&laquo;</span></a></li>";
        }
        if ($end) {
            for ($loop = $start; $loop <= $end; $loop++) {
                if ($loop == $this->cur_page) {
                    $output .= "<li class=\"active\"><a>{$loop}</a></li>";
                } else {
                    $output .= "<li><a href=\"".$this->parse_link($loop)."\">{$loop}</a></li>";
                }
            }
        }
        if ($this->cur_page < $num_pages) {
            $output .= "<li><a href=\"".$this->parse_link($this->cur_page + 1)."\" aria-label=\"Next\"><span aria-hidden=\"true\">&raquo;</span></a></li>";
            //$output .= "<a href=\"".$this->parse_link($num_pages)."\">".$this->last_link."</a>";
        }


        return $output;
    }
    
    /**
     * Generate the pagination links
     *
     * @access	public
     * @return	string
     */
    function create_links_()
    {
        // If our item count or per-page total is zero there is no need to continue.
        if ($this->total_rows == 0 or $this->per_page == 0) {
            return '';
        }

        // Calculate the total number of pages
        $num_pages = ceil($this->total_rows / $this->per_page);

        // Is there only one page? Hm... nothing more to do here then.
        if ($num_pages == 1) {
            return '';
        }

        $this->num_links = (int)$this->num_links;

        //if ($this->num_links < 1) {
        //show_error('Your number of links must be a positive number.');
        //}

        if (! is_numeric($this->cur_page)) {
            $this->cur_page = 1;
        }

        if ($this->cur_page > $num_pages) {
            $this->cur_page = $num_pages;
        }

        $this->page_start = $this->per_page * ($this->cur_page - 1);

        // Calculate the start and end numbers. These determine
        // which number to start and end the digit links with
        $start = (($this->cur_page - $this->num_links) > 0)?$this->cur_page - ($this->num_links - 1) : 1;
        $end = (($this->cur_page + $this->num_links) < $num_pages)?$this->cur_page + $this->num_links : $num_pages;

        // And here we go...
        $output = '';
        if ($this->cur_page > 1) {
            $output .= "<a href=\"".$this->parse_link(1)."\">".$this->first_link."</a>";
            $output .= "<a href=\"".$this->parse_link($this->cur_page - 1)."\">".$this->prev_link."</a>";
        }
        if ($end) {
            for ($loop = $start; $loop <= $end; $loop++) {
                if ($loop == $this->cur_page) {
                    $output .= "<a class=\"curpage\">{$loop}</a>";
                } else {
                    $output .= "<a href=\"".$this->parse_link($loop)."\">{$loop}</a>";
                }
            }
        }
        if ($this->cur_page < $num_pages) {
            $output .= "<a href=\"".$this->parse_link($this->cur_page + 1)."\">".$this->next_link."</a>";
            $output .= "<a href=\"".$this->parse_link($num_pages)."\">".$this->last_link."</a>";
        }


        return $output;
    }

    function parse_link($num)
    {
        // Determine the current page number.
        $CI = &get_instance();

        // Page Static
        $this->url_suffix = $CI->config->item('url_suffix');
        if ($this->page_static == true) {
            if ($num == 1) {
                $base_url = $this->base_url;
            } else {
                if (strchr($this->base_url, $this->url_suffix)) {
                    $base_url = substr($this->base_url, 0, strlen($this->base_url)-strlen($this->url_suffix))."/".$num.$this->url_suffix;
                } else {
                    $base_url = $this->base_url.$num.$this->url_suffix;
                }
            }
            $this->url_string && $base_url .= $this->url_string;
        } else {
            if ($this->url_string) {
                $base_url = $this->base_url.$this->url_string."&amp;page=".$num;
            } else {
                $base_url = $this->base_url."?page=".$num;
            }
        }
        return $base_url;
    }
}
// END Pagination Class

/* End of file Pagination.php */
/* Location: ./system/libraries/Pagination.php */

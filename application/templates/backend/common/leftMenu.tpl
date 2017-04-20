<!-- BEGIN SIDEBAR -->

		<div class="page-sidebar nav-collapse collapse">

			<!-- BEGIN SIDEBAR MENU -->        

			<ul class="page-sidebar-menu">

				<li>

					<!-- BEGIN SIDEBAR TOGGLER BUTTON -->

					<div class="sidebar-toggler hidden-phone"></div>

					<!-- BEGIN SIDEBAR TOGGLER BUTTON -->

				</li>

				<li>

					<!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->

					<!--<form class="sidebar-search">

						<div class="input-box">

							<a href="javascript:;" class="remove"></a>

							<input type="text" placeholder="Search..." />

							<input type="button" class="submit" value=" " />

						</div>

					</form>-->

					<!-- END RESPONSIVE QUICK SEARCH FORM -->
                    <div class="row hidden-480">&nbsp;</div>
				</li>
				<{if !isset($adminDealerId) || empty($adminDealerId)}>
				<li class="start <{if $currentMenuUrl == 'main'}> active <{/if}>">

					<a href="<{site_url uri=$backendDir|cat:'/main'}>">

					<i class="icon-home"></i> 

					<span class="title">主页</span>

					</a>

				</li>
				<{/if}>
                <{if $adminMenu}>
                <{foreach from=$adminMenu item = am}>
                <{if $am.parent_id == 0 && check_priv($am.action_code)}>

				<li class=" <{if $queue && $am.id|in_array:(','|explode:($queue|trim:','))}> active <{/if}>">

					<a href="javascript:;">

					<i class="<{$am.icon_class}>"></i> 

					<span class="title"><{$am.menu_title}></span>

					<span class="selected"></span>

					<span class="arrow open"></span>

					</a>
                    <{if $am.has_child}>
					<ul class="sub-menu">
                        <{foreach from=$adminMenu item = childAm}>
                        <{if $childAm.parent_id == $am.id && check_priv($childAm.action_code)}>
						<li class="<{if $queue && $childAm.id|in_array:(','|explode:($queue|trim:','))}> active <{/if}>">

							<a href="<{site_url uri=$backendDir|cat:'/'|cat:$childAm.menu_url}>">

							<{$childAm.menu_title}></a>

						</li>
                        <{/if}>
                        <{/foreach}>
						

					</ul>
                    <{/if}>
				</li>
                <{/if}>
                <{/foreach}>
                <{/if}>
				

			</ul>

			<!-- END SIDEBAR MENU -->

		</div>

		<!-- END SIDEBAR -->
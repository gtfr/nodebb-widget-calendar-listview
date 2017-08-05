<div id="calendar-listview">
<table class="calendar-listview-table">
    <colgroup>
        <col class="col-md-2">
        <col class="col-md-1">
        <col class="col-md-3">
        <col class="col-md-3">
        <col class="col-md-3">
    </colgroup>
    <!-- BEGIN days -->
    <tr class="calendar-listview-heading">
        <td colspan="2" style="text-align:left">{days.weekday}</td>
        <td colspan="3" style="text-align:right">{days.daystr}</td>
    </tr>
    <!-- BEGIN days.events -->
    <tr class="calendar-listview-row">
        <!-- IF days.events.allday -->
        <td rowspan="2">&emsp;<i class="fa fa-spinner" style="color:grey"></i></td>
        <!-- ELSE -->
        <td rowspan="2">{days.events.time} - {days.events.endtime}</td>
        <!-- ENDIF days.events.allday -->
        <td rowspan="2"><a href="/calendar/event/{days.events.pid}/{days.events.day}"><i class="fa fa-calendar-o"></i></a></td>
        <td colspan="3">{days.events.name}</td>
    </tr>
    <tr class="calendar-listview-row">
        <td><i class="fa fa-check-circle" style="color:grey"></i>:&nbsp;
            <!-- IF !days.events.responses.yes.length -->
            -&nbsp;
            <!-- ENDIF !days.events.responses.yes.length -->
            <!-- BEGIN days.events.responses.yes -->
            <a data-uid="{days.events.responses.yes.uid}" href="/user/{days.events.responses.yes.userslug}">
                <!-- IF days.events.responses.yes.picture -->
                <img title="" src="{days.events.responses.yes.picture}" class="avatar avatar-sm not-responsive" data-original-title="{days.events.responses.yes.username}"></a>
                <!-- ELSE -->
                <div title="{days.events.responses.yes.username}" class="avatar avatar-sm avatar-rounded not-responsive" style="background-color: {days.events.responses.yes.icon:bgColor};">{days.events.responses.yes.icon:text}</div>
            <!-- ENDIF days.events.responses.yes.picture -->
            <!-- END days.events.responses.yes -->
        </td>
        <td><i class="fa fa-question-circle" style="color:grey"></i>:&nbsp;
            <!-- IF !days.events.responses.maybe.length -->
            -&nbsp;
            <!-- ENDIF !days.events.responses.maybe.length -->
            <!-- BEGIN days.events.responses.maybe -->
            <a data-uid="{days.events.responses.maybe.uid}" href="/user/{days.events.responses.maybe.userslug}">
                <!-- IF days.events.responses.maybe.picture -->
                <img title="" src="{days.events.responses.maybe.picture}" class="avatar avatar-sm not-responsive" data-original-title="{days.events.responses.maybe.username}"></a>
                <!-- ELSE -->
                <div title="{days.events.responses.maybe.username}" class="avatar avatar-sm avatar-rounded not-responsive" style="background-color: {days.events.responses.maybe.icon:bgColor};">{days.events.responses.maybe.icon:text}</div>
            <!-- ENDIF days.events.responses.maybe.picture -->
            <!-- END days.events.responses.maybe -->
        </td>
        <td><i class="fa fa-times-circle" style="color:grey"></i>:&nbsp;
            <!-- IF !days.events.responses.no.length -->
            -&nbsp;
            <!-- ENDIF !days.events.responses.no.length -->
            <!-- BEGIN days.events.responses.no -->
            <a data-uid="{days.events.responses.no.uid}" href="/user/{days.events.responses.no.userslug}">
                <!-- IF days.events.responses.no.picture -->
                <img title="" src="{days.events.responses.no.picture}" class="avatar avatar-sm not-responsive" data-original-title="{days.events.responses.no.username}"></a>
                <!-- ELSE -->
                <div title="{days.events.responses.no.username}" class="avatar avatar-sm avatar-rounded not-responsive" style="background-color: {days.events.responses.no.icon:bgColor};">{days.events.responses.no.icon:text}</div>
            <!-- ENDIF days.events.responses.no.picture -->
            <!-- END days.events.responses.no -->
        </td>
    </tr>
    <!-- END days.events -->
    <!-- END days -->
</table>
</div>

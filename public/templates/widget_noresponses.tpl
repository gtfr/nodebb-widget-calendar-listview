<div id="calendar-listview">
<table class="calendar-listview-table">
    <colgroup>
        <col class="col-md-2">
        <col class="col-md-1">
        <col class="col-md-9">
    </colgroup>
    <!-- BEGIN days -->
    <tr class="calendar-listview-heading">
        <td colspan="1" style="text-align:left">{days.weekday}</td>
        <td colspan="2" style="text-align:right">{days.daystr}</td>
    </tr>
    <!-- BEGIN days.events -->
    <tr class="calendar-listview-row">
        <!-- IF days.events.allday -->
        <td>&emsp;<i class="fa fa-spinner" style="color:grey"></i></td>
        <!-- ENDIF days.events.allday -->
        <!-- IF !days.events.allday -->
        <td>{days.events.time} - {days.events.endtime}</td>
        <!-- ENDIF !days.events.allday -->
        <td><a href="/calendar/event/{days.events.pid}/{days.events.day}"><i class="fa fa-calendar-o"></i></a></td>
        <td>{days.events.name}</td>
    </tr>
    <!-- END days.events -->
    <!-- END days -->
</table>
</div>

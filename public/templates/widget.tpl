<table class="calendar-listview-table">
    <colgroup>
        <col width=150px>
        <col width=10px>
     </colgroup>
    <!-- BEGIN days -->
    <tr class="calendar-listview-heading">
        <!-- IF showresponse -->
        <td colspan="5">{days.daystr}</td>
        <!-- ENDIF showresponse -->
        <!-- IF !showresponse -->
        <td colspan="3">{days.daystr}</td>
        <!-- ENDIF !showresponse -->
    </tr>
    <!-- BEGIN days.events -->
    <tr class="calendar-listview-row">
        <!-- IF showresponse -->
        <td rowspan="2">{days.events.time} - {days.events.endtime}</td>
        <td rowspan="2"><a href="/calendar/event/{days.events.pid}/{days.events.day}"><i class="fa fa-calendar-o"></i></a></td>
        <td colspan="3">{days.events.name}</td>
        <!-- ENDIF showresponse -->
        <!-- IF !showresponse -->
        <td>{days.events.time} - {days.events.endtime}</td>
        <td><a href="/calendar/event/{days.events.pid}/{days.events.day}"><i class="fa fa-calendar-o"></i></a></td>
        <td>{days.events.name}</td>
        <!-- ENDIF !showresponse -->
    </tr>
    <!-- IF showresponse -->
    <tr class="calendar-listview-row">
        <td><i class="fa fa-check-circle text-success"></i>:&nbsp;
            <!-- BEGIN days.events.responses.yes -->
            <a data-uid="{days.events.responses.yes.uid}" href="/user/{days.events.responses.yes.userslug}">
                        <img title="" src="{days.events.responses.yes.picture}" class="avatar avatar-sm not-responsive" data-original-title="{days.events.responses.yes.username}"></a>
            <!-- END days.events.responses.yes -->
        </td>
        <td><i class="fa fa-question-circle"></i>:&nbsp;
            <!-- BEGIN days.events.responses.maybe -->
            <a data-uid="{days.events.responses.maybe.uid}" href="/user/{days.events.responses.maybe.userslug}">
                        <img title="" src="{days.events.responses.maybe.picture}" class="avatar avatar-sm not-responsive" data-original-title="{days.events.responses.maybe.username}"></a>
            <!-- END days.events.responses.maybe -->
        </td>
        <td><i class="fa fa-times-circle text-danger"></i>:&nbsp;
            <!-- BEGIN days.events.responses.no -->
            <a data-uid="{days.events.responses.no.uid}" href="/user/{days.events.responses.no.userslug}">
                        <img title="" src="{days.events.responses.no.picture}" class="avatar avatar-sm not-responsive" data-original-title="{days.events.responses.no.username}"></a>
            <!-- END days.events.responses.no -->
        </td>
    </tr>
    <!-- ENDIF showresponse -->
    <!-- END days.events -->
    <!-- END days -->
</table>

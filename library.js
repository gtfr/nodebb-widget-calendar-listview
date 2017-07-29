(function(module) {
    "use strict";

    const meta = require.main.require('./src/meta');
    const user = require.main.require('./src/user');

    var async = require('async'),
        fs = require('fs'),
        path = require('path'),
        moment = require('moment'),
        templates = module.parent.require('templates.js'),
        calendarev = require('nodebb-plugin-calendar/build/lib/event.js'),
        calendarpriv = require('nodebb-plugin-calendar/build/lib/privileges.js'),
        calendarrep = require('nodebb-plugin-calendar/build/lib/repetition.js'),
        calendarresp = require('nodebb-plugin-calendar/build/lib/responses.js'),
        app;

    var Widget = {
        templates: {},
    };

    Widget.init = function(params, callback) {
        app = params.app;
        console.log('[listview-widget] init: %s', calendarev.listKey)

        var templatesToLoad = [
            "settings.tpl",
            "widget.tpl",
            "widget_noresponses.tpl"
        ];

        function loadTemplate(template, next) {
            fs.readFile(path.resolve(__dirname, './public/templates/' + template), function(err, data) {
                if (err) {
                    console.log(err.message);
                    return next(err);
                }
                Widget.templates[template] = data.toString();
                next(null);
            });
        }

        async.each(templatesToLoad, loadTemplate);
        console.log('[listview-widget] locale: %s', moment.locale());

        callback();
    };

    Widget.renderListviewWidget = function(widget, callback) {
        console.log('[listview-widget] renderListviewWidget called');

        var start = moment().valueOf(),
            end = moment().valueOf(),
            lang = 'en-GB';

        async.waterfall([
                function (next) {
        			user.getSettings(widget.uid, next);
        		},
        		function (settings, next) {
        			lang = settings.userLang || meta.config.defaultLang || lang;
                    moment.locale(lang);
                    console.log('[listview-widget] user %s, locale: %s', widget.uid, lang);
                    next();
        		},
                function(next) {
                    start = moment().startOf(widget.data.period).valueOf();
                    end = moment().endOf(widget.data.period).valueOf();
                    console.log('[listview-widget] from: %s, to: %s', start, end);
                    calendarev.getEventsByDate(start, end).then(function(events) {
                        next(null, events);
                    });
                },
                function(events, next) {
                    // console.log('[listview-widget] Data: ' + JSON.stringify(events, null, 2));
                    calendarpriv.filterByPid(events, widget.uid).then(function(filtered) {
                        next(null, filtered);
                    });
                },
                function(filtered, next) {
                    const occurences = filtered.reduce((prev, event) => {
                        if (event.repeats && event.repeats.every) {
                            return [...prev, ...calendarrep.getOccurencesOfRepetition(event, start, end)];
                        }
                        event.day = (new Date(event.startDate)).toISOString().split('T')[0];
                        return [...prev, event];
                    }, []);
                    // console.log('[listview-widget] Data: ' + JSON.stringify(occurences, null, 2));
                    next(null, occurences);
                },
                function(occurences, next) {
                    var data = [];

                    async.each(occurences, function(element, callback) {
                        var par = {
                            pid: element.pid,
                            uid: widget.uid
                        };
                        if (element.repeats && element.repeats.every) {
                            par.day = element.day;
                        };
                        calendarresp.getAll(par).then(function(response) {
                            // console.log('[listview-widget] Event: %s, Day: %s', element.name, element.day);
                            // console.log('[listview-widget] Response: ' + JSON.stringify(response, null, 2));
                            data.push({
                                name: element.name,
                                allday: element.allday,
                                day: element.day,
                                daystr: (new moment(element.day)).format("LL"),
                                weekday: (new moment(element.day)).format("dddd"),
                                time: (new moment(element.startDate)).format("LT"),
                                endtime: (new moment(element.endDate)).format("LT"),
                                pid: element.pid,
                                responses: response
                            });
                            callback(null);
                        });
                    }, function(err) {
                        if (err) {
                            next(err);
                        } else {
                            next(null, data);
                        }
                    });
                },
                function(data, next) {
                    data.sort(function(a, b) {
                        if (a.day === b.day) {
                            if (a.alldays) {
                                return -1;
                            } else if (b.allday) {
                                return 1;
                            } else {
                                return a.time < b.time ? -1 : a.time > b.time ? 1 : 0;
                            }
                        } else {
                            return a.day < b.day ? -1 : 1
                        }
                    });
                    next(null, data)
                },
                function(data, next) {
                    var result = {
                        days: [],
                        showresponse: widget.data.showresponse
                    };
                    data.forEach(function(element, index) {
                        if (index === 0 || data[index - 1].day !== element.day) {
                            result.days.push({
                                day: element.day,
                                daystr: element.daystr,
                                weekday: element.weekday,
                                events: [element]
                            });
                        } else {
                            result.days[result.days.length - 1].events.push(element);
                        }
                    });
                    next(null, result);
                }
            ],
            function(err, result) {
                if (err) {
                    console.log('[listview-widget] Error: See widget content');
                    widget.html = '<h4>An Error occurred:<h4><pre>' + JSON.stringify(err, null, 2) + '</pre>';
                } else {
                    // console.log('[listview-widget] Data:' + JSON.stringify(result, null, 2));
                    if (widget.data.showresponse) {
                        widget.html = templates.parse(Widget.templates['widget.tpl'], result);
                    } else {
                        widget.html = templates.parse(Widget.templates['widget_noresponses.tpl'], result);
                    }
                }
                callback(null, widget);
            });
    };

    Widget.defineWidget = function(widgets, callback) {
        widgets.push({
            widget: "calendar-listview",
            name: "NodeBB Listview Widget for Calendar Plugin",
            description: "Adds a widget to show Listview for Calendar Plugin",
            content: Widget.templates['settings.tpl']
        });

        callback(null, widgets);
    };


    module.exports = Widget;
}(module));

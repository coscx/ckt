import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
  <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    //return defaultValue;
  }
  if ('' is T) {
    return '' as T;
  } else if (0 is T) {
    return 0 as T;
  } else if (0.0 is T) {
    return 0.0 as T;
  } else if (false is T) {
    return false as T;
  }
  return defaultValue;
}

class Root {
  Root({
    this.agent,
    this.robot,
    this.feedback,
    this.customer,
    this.tip,
    this.label,
    this.feedbackTab,
    this.vcall,
    this.ticket,
    this.event,
    this.components,
  });

  factory Root.fromJson(Map<String, dynamic> json) => Root(
    agent: json.containsKey('agent')
        ? json['agent'] == null
        ? null
        : Agent.fromJson(asT<Map<String, dynamic>>(json['agent'])!)
        : null,
    robot: json.containsKey('robot')
        ? json['robot'] == null
        ? null
        : Robot.fromJson(asT<Map<String, dynamic>>(json['robot'])!)
        : null,
    feedback: json.containsKey('feedback')
        ? json['feedback'] == null
        ? null
        : Feedback.fromJson(
        asT<Map<String, dynamic>>(json['feedback'])!)
        : null,
    customer: json.containsKey('customer')
        ? asT<Map<String, dynamic>?>(json['customer'])
        : null,
    tip: json.containsKey('tip')
        ? json['tip'] == null
        ? null
        : Tip.fromJson(asT<Map<String, dynamic>>(json['tip'])!)
        : null,
    label: json.containsKey('label')
        ? json['label'] == null
        ? null
        : Label.fromJson(asT<Map<String, dynamic>>(json['label'])!)
        : null,
    feedbackTab: json.containsKey('feedbackTab')
        ? json['feedbackTab'] == null
        ? null
        : FeedbackTab.fromJson(
        asT<Map<String, dynamic>>(json['feedbackTab'])!)
        : null,
    vcall: json.containsKey('vcall')
        ? json['vcall'] == null
        ? null
        : Vcall.fromJson(asT<Map<String, dynamic>>(json['vcall'])!)
        : null,
    ticket: json.containsKey('ticket')
        ? json['ticket'] == null
        ? null
        : Ticket.fromJson(asT<Map<String, dynamic>>(json['ticket'])!)
        : null,
    event: json.containsKey('event')
        ? json['event'] == null
        ? null
        : Event.fromJson(asT<Map<String, dynamic>>(json['event'])!)
        : null,
    components: json.containsKey('components')
        ? json['components'] == null
        ? null
        : Components.fromJson(
        asT<Map<String, dynamic>>(json['components'])!)
        : null,
  );

  Agent? agent;
  Robot? robot;
  Feedback? feedback;
  Map<String, dynamic>? customer;
  Tip? tip;
  Label? label;
  FeedbackTab? feedbackTab;
  Vcall? vcall;
  Ticket? ticket;
  Event? event;
  Components? components;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'agent': agent,
    'robot': robot,
    'feedback': feedback,
    'customer': customer,
    'tip': tip,
    'label': label,
    'feedbackTab': feedbackTab,
    'vcall': vcall,
    'ticket': ticket,
    'event': event,
    'components': components,
  };
}

class Agent {
  Agent({
    this.title,
    this.onlineAg,
    this.transfer,
    this.over,
    this.newChat,
    this.agOffline,
    this.queue,
    this.queueTip,
    this.leaveMsgTip,
    this.choiceAgent,
    this.blackList,
    this.tip,
    this.transferring,
    this.transferred,
    this.askSurvey,
    this.name,
    this.jobNo,
    this.email,
    this.telephone,
    this.serviceSurveyTip1,
    this.typing,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    title: json.containsKey('title') ? asT<String?>(json['title']) : null,
    onlineAg: json.containsKey('onlineAg')
        ? asT<String?>(json['onlineAg'])
        : null,
    transfer: json.containsKey('transfer')
        ? asT<String?>(json['transfer'])
        : null,
    over: json.containsKey('over') ? asT<String?>(json['over']) : null,
    newChat:
    json.containsKey('newChat') ? asT<String?>(json['newChat']) : null,
    agOffline: json.containsKey('agOffline')
        ? asT<String?>(json['agOffline'])
        : null,
    queue: json.containsKey('queue') ? asT<String?>(json['queue']) : null,
    queueTip: json.containsKey('queueTip')
        ? asT<String?>(json['queueTip'])
        : null,
    leaveMsgTip: json.containsKey('leaveMsgTip')
        ? asT<String?>(json['leaveMsgTip'])
        : null,
    choiceAgent: json.containsKey('choiceAgent')
        ? asT<String?>(json['choiceAgent'])
        : null,
    blackList: json.containsKey('blackList')
        ? asT<String?>(json['blackList'])
        : null,
    tip: json.containsKey('tip') ? asT<String?>(json['tip']) : null,
    transferring: json.containsKey('transferring')
        ? asT<String?>(json['transferring'])
        : null,
    transferred: json.containsKey('transferred')
        ? asT<String?>(json['transferred'])
        : null,
    askSurvey: json.containsKey('askSurvey')
        ? asT<String?>(json['askSurvey'])
        : null,
    name: json.containsKey('name') ? asT<String?>(json['name']) : null,
    jobNo: json.containsKey('jobNo') ? asT<String?>(json['jobNo']) : null,
    email: json.containsKey('email') ? asT<String?>(json['email']) : null,
    telephone: json.containsKey('telephone')
        ? asT<String?>(json['telephone'])
        : null,
    serviceSurveyTip1: json.containsKey('serviceSurveyTip1')
        ? asT<String?>(json['serviceSurveyTip1'])
        : null,
    typing:
    json.containsKey('typing') ? asT<String?>(json['typing']) : null,
  );

  String? title;
  String? onlineAg;
  String? transfer;
  String? over;
  String? newChat;
  String? agOffline;
  String? queue;
  String? queueTip;
  String? leaveMsgTip;
  String? choiceAgent;
  String? blackList;
  String? tip;
  String? transferring;
  String? transferred;
  String? askSurvey;
  String? name;
  String? jobNo;
  String? email;
  String? telephone;
  String? serviceSurveyTip1;
  String? typing;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'onlineAg': onlineAg,
    'transfer': transfer,
    'over': over,
    'newChat': newChat,
    'agOffline': agOffline,
    'queue': queue,
    'queueTip': queueTip,
    'leaveMsgTip': leaveMsgTip,
    'choiceAgent': choiceAgent,
    'blackList': blackList,
    'tip': tip,
    'transferring': transferring,
    'transferred': transferred,
    'askSurvey': askSurvey,
    'name': name,
    'jobNo': jobNo,
    'email': email,
    'telephone': telephone,
    'serviceSurveyTip1': serviceSurveyTip1,
    'typing': typing,
  };
}

class Robot {
  Robot({
    this.receiveFeedback,
    this.feedback,
    this.guess,
    this.refresh,
    this.title,
    this.name,
    this.isSatisfied,
    this.satisfied,
    this.unsatisfied,
    this.general,
    this.thanks,
    this.hasSurvey,
    this.thankFeedback,
    this.useful,
    this.useless,
    this.questions,
    this.robotSurvey,
    this.robotSurveyPerson,
    this.commonProblem,
    this.autoSwitchStaffTips,
    this.aicpRobotName,
    this.resolved,
    this.unResolved,
    this.fetchRobotConfigFailed,
    this.uselessTransferTip,
  });

  factory Robot.fromJson(Map<String, dynamic> json) => Robot(
    receiveFeedback: json.containsKey('receiveFeedback')
        ? asT<String?>(json['receiveFeedback'])
        : null,
    feedback: json.containsKey('feedback')
        ? asT<String?>(json['feedback'])
        : null,
    guess: json.containsKey('guess') ? asT<String?>(json['guess']) : null,
    refresh:
    json.containsKey('refresh') ? asT<String?>(json['refresh']) : null,
    title: json.containsKey('title') ? asT<String?>(json['title']) : null,
    name: json.containsKey('name') ? asT<String?>(json['name']) : null,
    isSatisfied: json.containsKey('isSatisfied')
        ? asT<String?>(json['isSatisfied'])
        : null,
    satisfied: json.containsKey('satisfied')
        ? asT<String?>(json['satisfied'])
        : null,
    unsatisfied: json.containsKey('unsatisfied')
        ? asT<String?>(json['unsatisfied'])
        : null,
    general:
    json.containsKey('general') ? asT<String?>(json['general']) : null,
    thanks:
    json.containsKey('thanks') ? asT<String?>(json['thanks']) : null,
    hasSurvey: json.containsKey('hasSurvey')
        ? asT<String?>(json['hasSurvey'])
        : null,
    thankFeedback: json.containsKey('thankFeedback')
        ? asT<String?>(json['thankFeedback'])
        : null,
    useful:
    json.containsKey('useful') ? asT<String?>(json['useful']) : null,
    useless:
    json.containsKey('useless') ? asT<String?>(json['useless']) : null,
    questions: json.containsKey('questions')
        ? asT<String?>(json['questions'])
        : null,
    robotSurvey: json.containsKey('robotSurvey')
        ? asT<String?>(json['robotSurvey'])
        : null,
    robotSurveyPerson: json.containsKey('robotSurveyPerson')
        ? asT<String?>(json['robotSurveyPerson'])
        : null,
    commonProblem: json.containsKey('commonProblem')
        ? asT<String?>(json['commonProblem'])
        : null,
    autoSwitchStaffTips: json.containsKey('autoSwitchStaffTips')
        ? asT<String?>(json['autoSwitchStaffTips'])
        : null,
    aicpRobotName: json.containsKey('aicpRobotName')
        ? asT<String?>(json['aicpRobotName'])
        : null,
    resolved: json.containsKey('resolved')
        ? asT<String?>(json['resolved'])
        : null,
    unResolved: json.containsKey('unResolved')
        ? asT<String?>(json['unResolved'])
        : null,
    fetchRobotConfigFailed: json.containsKey('fetch_robot_config_failed')
        ? asT<String?>(json['fetch_robot_config_failed'])
        : null,
    uselessTransferTip: json.containsKey('useless_transfer_tip')
        ? asT<String?>(json['useless_transfer_tip'])
        : null,
  );

  String? receiveFeedback;
  String? feedback;
  String? guess;
  String? refresh;
  String? title;
  String? name;
  String? isSatisfied;
  String? satisfied;
  String? unsatisfied;
  String? general;
  String? thanks;
  String? hasSurvey;
  String? thankFeedback;
  String? useful;
  String? useless;
  String? questions;
  String? robotSurvey;
  String? robotSurveyPerson;
  String? commonProblem;
  String? autoSwitchStaffTips;
  String? aicpRobotName;
  String? resolved;
  String? unResolved;
  String? fetchRobotConfigFailed;
  String? uselessTransferTip;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'receiveFeedback': receiveFeedback,
    'feedback': feedback,
    'guess': guess,
    'refresh': refresh,
    'title': title,
    'name': name,
    'isSatisfied': isSatisfied,
    'satisfied': satisfied,
    'unsatisfied': unsatisfied,
    'general': general,
    'thanks': thanks,
    'hasSurvey': hasSurvey,
    'thankFeedback': thankFeedback,
    'useful': useful,
    'useless': useless,
    'questions': questions,
    'robotSurvey': robotSurvey,
    'robotSurveyPerson': robotSurveyPerson,
    'commonProblem': commonProblem,
    'autoSwitchStaffTips': autoSwitchStaffTips,
    'aicpRobotName': aicpRobotName,
    'resolved': resolved,
    'unResolved': unResolved,
    'fetch_robot_config_failed': fetchRobotConfigFailed,
    'useless_transfer_tip': uselessTransferTip,
  };
}

class Feedback {
  Feedback({
    this.title,
    this.titleWord,
    this.leaveMmessage,
    this.leaveMsgTip,
    this.success,
    this.leaveMsgAgain,
    this.captchaCode,
    this.nickName,
    this.email,
    this.cellphone,
    this.upload,
    this.uploadTip,
    this.saveError,
    this.leaveFormLoading,
    this.problemDescription,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    title: json.containsKey('title') ? asT<String?>(json['title']) : null,
    titleWord: json.containsKey('titleWord')
        ? asT<String?>(json['titleWord'])
        : null,
    leaveMmessage: json.containsKey('LeaveMmessage')
        ? asT<String?>(json['LeaveMmessage'])
        : null,
    leaveMsgTip: json.containsKey('leaveMsgTip')
        ? asT<String?>(json['leaveMsgTip'])
        : null,
    success:
    json.containsKey('success') ? asT<String?>(json['success']) : null,
    leaveMsgAgain: json.containsKey('leaveMsgAgain')
        ? asT<String?>(json['leaveMsgAgain'])
        : null,
    captchaCode: json.containsKey('captchaCode')
        ? asT<String?>(json['captchaCode'])
        : null,
    nickName: json.containsKey('nick_name')
        ? asT<String?>(json['nick_name'])
        : null,
    email: json.containsKey('email') ? asT<String?>(json['email']) : null,
    cellphone: json.containsKey('cellphone')
        ? asT<String?>(json['cellphone'])
        : null,
    upload:
    json.containsKey('upload') ? asT<String?>(json['upload']) : null,
    uploadTip: json.containsKey('upload_tip')
        ? asT<String?>(json['upload_tip'])
        : null,
    saveError: json.containsKey('saveError')
        ? asT<String?>(json['saveError'])
        : null,
    leaveFormLoading: json.containsKey('leaveFormLoading')
        ? asT<String?>(json['leaveFormLoading'])
        : null,
    problemDescription: json.containsKey('problemDescription')
        ? asT<String?>(json['problemDescription'])
        : null,
  );

  String? title;
  String? titleWord;
  String? leaveMmessage;
  String? leaveMsgTip;
  String? success;
  String? leaveMsgAgain;
  String? captchaCode;
  String? nickName;
  String? email;
  String? cellphone;
  String? upload;
  String? uploadTip;
  String? saveError;
  String? leaveFormLoading;
  String? problemDescription;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'titleWord': titleWord,
    'LeaveMmessage': leaveMmessage,
    'leaveMsgTip': leaveMsgTip,
    'success': success,
    'leaveMsgAgain': leaveMsgAgain,
    'captchaCode': captchaCode,
    'nick_name': nickName,
    'email': email,
    'cellphone': cellphone,
    'upload': upload,
    'upload_tip': uploadTip,
    'saveError': saveError,
    'leaveFormLoading': leaveFormLoading,
    'problemDescription': problemDescription,
  };
}

class Tip {
  Tip({
    this.closeSession,
    this.evaluationDialogue,
    this.rateService,
    this.surveyRemark,
    this.accessError,
    this.buttonHasExpired,
    this.unreadMessage,
    this.robotError,
    this.disconnect,
    this.agOffline,
    this.noAgent,
    this.forbid,
    this.forbidAdmin,
    this.logoutTip,
    this.connectFail,
    this.retry,
    this.reConnectFail,
    this.dataFail,
    this.success,
    this.fail,
    this.newMsg,
    this.newMsgTitle,
    this.chatOver,
    this.pleaseSurvey,
    this.transferSuccess,
    this.service,
    this.confirmClose,
    this.haveNotSurvey,
    this.stay,
    this.leave,
    this.selectOne,
    this.lastLevel,
    this.input,
    this.emailError,
    this.phoneError,
    this.phoneerror0,
    this.phoneerror1,
    this.phoneerror2,
    this.fmtError,
    this.validCode,
    this.reenter,
    this.historyMsg,
    this.noMoreMsg,
    this.moreMsg,
    this.seeMore,
    this.putItAway,
    this.overMaxLength,
    this.rq,
    this.agentTransferSuccess,
    this.please,
    this.download,
    this.downloadPlugin,
    this.downloadPlugin2,
    this.install,
    this.getCodeError,
    this.lessWords,
    this.saveFail,
    this.downloadFail,
    this.noMsgRecord,
    this.updateFlash,
    this.sendFail,
    this.overLimit,
    this.forbidType,
    this.overSize,
    this.uploadSuccess,
    this.overxm,
    this.uploadTip,
    this.uploadError,
    this.uploadErrorRetry,
    this.newError,
    this.wrongRequest,
    this.networkError,
    this.validRequest,
    this.robotWrong,
    this.agentService,
    this.networkWeek,
    this.optSuccess,
    this.connectError,
    this.noAgentOnline,
    this.uploadSuc,
    this.uploadErr,
    this.fileFail,
    this.positiveInt,
    this.date,
    this.time,
    this.link,
    this.int,
    this.pleaseChoice,
    this.noFill,
    this.wrongPhone,
    this.wrongLink,
    this.subSuc,
    this.subFail,
    this.customerForm,
    this.phoneForm,
    this.emailForm,
    this.fileError,
    this.fileGT,
    this.downloadLastChats,
    this.voice,
    this.reqError,
    this.sensitiveWords,
    this.placeInputHere,
    this.surveyRemarkRequire,
    this.contactUs,
    this.unreadMsgs,
    this.customerClose,
    this.closeChat,
    this.transferAgent,
    this.agentRequest,
    this.privacyPolicyError,
    this.httpCode429,
    this.hasUnreadMsgs,
    this.askAudioPremission,
  });

  factory Tip.fromJson(Map<String, dynamic> json) => Tip(
    closeSession: json.containsKey('closeSession')
        ? asT<String?>(json['closeSession'])
        : null,
    evaluationDialogue: json.containsKey('evaluationDialogue')
        ? asT<String?>(json['evaluationDialogue'])
        : null,
    rateService: json.containsKey('rateService')
        ? asT<String?>(json['rateService'])
        : null,
    surveyRemark: json.containsKey('surveyRemark')
        ? asT<String?>(json['surveyRemark'])
        : null,
    accessError: json.containsKey('accessError')
        ? asT<String?>(json['accessError'])
        : null,
    buttonHasExpired: json.containsKey('button_has_expired')
        ? asT<String?>(json['button_has_expired'])
        : null,
    unreadMessage: json.containsKey('unreadMessage')
        ? asT<String?>(json['unreadMessage'])
        : null,
    robotError: json.containsKey('robotError')
        ? asT<String?>(json['robotError'])
        : null,
    disconnect: json.containsKey('disconnect')
        ? asT<String?>(json['disconnect'])
        : null,
    agOffline: json.containsKey('agOffline')
        ? asT<String?>(json['agOffline'])
        : null,
    noAgent:
    json.containsKey('noAgent') ? asT<String?>(json['noAgent']) : null,
    forbid:
    json.containsKey('forbid') ? asT<String?>(json['forbid']) : null,
    forbidAdmin: json.containsKey('forbidAdmin')
        ? asT<String?>(json['forbidAdmin'])
        : null,
    logoutTip: json.containsKey('logoutTip')
        ? asT<String?>(json['logoutTip'])
        : null,
    connectFail: json.containsKey('connectFail')
        ? asT<String?>(json['connectFail'])
        : null,
    retry: json.containsKey('retry') ? asT<String?>(json['retry']) : null,
    reConnectFail: json.containsKey('reConnectFail')
        ? asT<String?>(json['reConnectFail'])
        : null,
    dataFail: json.containsKey('dataFail')
        ? asT<String?>(json['dataFail'])
        : null,
    success:
    json.containsKey('success') ? asT<String?>(json['success']) : null,
    fail: json.containsKey('fail') ? asT<String?>(json['fail']) : null,
    newMsg:
    json.containsKey('newMsg') ? asT<String?>(json['newMsg']) : null,
    newMsgTitle: json.containsKey('newMsgTitle')
        ? asT<String?>(json['newMsgTitle'])
        : null,
    chatOver: json.containsKey('chatOver')
        ? asT<String?>(json['chatOver'])
        : null,
    pleaseSurvey: json.containsKey('pleaseSurvey')
        ? asT<String?>(json['pleaseSurvey'])
        : null,
    transferSuccess: json.containsKey('transferSuccess')
        ? asT<String?>(json['transferSuccess'])
        : null,
    service:
    json.containsKey('service') ? asT<String?>(json['service']) : null,
    confirmClose: json.containsKey('confirmClose')
        ? asT<String?>(json['confirmClose'])
        : null,
    haveNotSurvey: json.containsKey('haveNotSurvey')
        ? asT<String?>(json['haveNotSurvey'])
        : null,
    stay: json.containsKey('stay') ? asT<String?>(json['stay']) : null,
    leave: json.containsKey('leave') ? asT<String?>(json['leave']) : null,
    selectOne: json.containsKey('selectOne')
        ? asT<String?>(json['selectOne'])
        : null,
    lastLevel: json.containsKey('lastLevel')
        ? asT<String?>(json['lastLevel'])
        : null,
    input: json.containsKey('input') ? asT<String?>(json['input']) : null,
    emailError: json.containsKey('emailError')
        ? asT<String?>(json['emailError'])
        : null,
    phoneError: json.containsKey('phoneError')
        ? asT<String?>(json['phoneError'])
        : null,
    phoneerror0: json.containsKey('phoneError-0')
        ? asT<String?>(json['phoneError-0'])
        : null,
    phoneerror1: json.containsKey('phoneError-1')
        ? asT<String?>(json['phoneError-1'])
        : null,
    phoneerror2: json.containsKey('phoneError-2')
        ? asT<String?>(json['phoneError-2'])
        : null,
    fmtError: json.containsKey('fmtError')
        ? asT<String?>(json['fmtError'])
        : null,
    validCode: json.containsKey('validCode')
        ? asT<String?>(json['validCode'])
        : null,
    reenter:
    json.containsKey('reenter') ? asT<String?>(json['reenter']) : null,
    historyMsg: json.containsKey('historyMsg')
        ? asT<String?>(json['historyMsg'])
        : null,
    noMoreMsg: json.containsKey('noMoreMsg')
        ? asT<String?>(json['noMoreMsg'])
        : null,
    moreMsg:
    json.containsKey('moreMsg') ? asT<String?>(json['moreMsg']) : null,
    seeMore:
    json.containsKey('seeMore') ? asT<String?>(json['seeMore']) : null,
    putItAway: json.containsKey('putItAway')
        ? asT<String?>(json['putItAway'])
        : null,
    overMaxLength: json.containsKey('overMaxLength')
        ? asT<String?>(json['overMaxLength'])
        : null,
    rq: json.containsKey('rq') ? asT<String?>(json['rq']) : null,
    agentTransferSuccess: json.containsKey('agentTransferSuccess')
        ? asT<String?>(json['agentTransferSuccess'])
        : null,
    please:
    json.containsKey('please') ? asT<String?>(json['please']) : null,
    download: json.containsKey('download')
        ? asT<String?>(json['download'])
        : null,
    downloadPlugin: json.containsKey('downloadPlugin')
        ? asT<String?>(json['downloadPlugin'])
        : null,
    downloadPlugin2: json.containsKey('downloadPlugin2')
        ? asT<String?>(json['downloadPlugin2'])
        : null,
    install:
    json.containsKey('install') ? asT<String?>(json['install']) : null,
    getCodeError: json.containsKey('getCodeError')
        ? asT<String?>(json['getCodeError'])
        : null,
    lessWords: json.containsKey('lessWords')
        ? asT<String?>(json['lessWords'])
        : null,
    saveFail: json.containsKey('saveFail')
        ? asT<String?>(json['saveFail'])
        : null,
    downloadFail: json.containsKey('downloadFail')
        ? asT<String?>(json['downloadFail'])
        : null,
    noMsgRecord: json.containsKey('noMsgRecord')
        ? asT<String?>(json['noMsgRecord'])
        : null,
    updateFlash: json.containsKey('updateFlash')
        ? asT<String?>(json['updateFlash'])
        : null,
    sendFail: json.containsKey('sendFail')
        ? asT<String?>(json['sendFail'])
        : null,
    overLimit: json.containsKey('overLimit')
        ? asT<String?>(json['overLimit'])
        : null,
    forbidType: json.containsKey('forbidType')
        ? asT<String?>(json['forbidType'])
        : null,
    overSize: json.containsKey('overSize')
        ? asT<String?>(json['overSize'])
        : null,
    uploadSuccess: json.containsKey('uploadSuccess')
        ? asT<String?>(json['uploadSuccess'])
        : null,
    overxm:
    json.containsKey('overxm') ? asT<String?>(json['overxm']) : null,
    uploadTip: json.containsKey('upload_tip')
        ? asT<String?>(json['upload_tip'])
        : null,
    uploadError: json.containsKey('uploadError')
        ? asT<String?>(json['uploadError'])
        : null,
    uploadErrorRetry: json.containsKey('uploadErrorRetry')
        ? asT<String?>(json['uploadErrorRetry'])
        : null,
    newError: json.containsKey('newError')
        ? asT<String?>(json['newError'])
        : null,
    wrongRequest: json.containsKey('wrongRequest')
        ? asT<String?>(json['wrongRequest'])
        : null,
    networkError: json.containsKey('networkError')
        ? asT<String?>(json['networkError'])
        : null,
    validRequest: json.containsKey('validRequest')
        ? asT<String?>(json['validRequest'])
        : null,
    robotWrong: json.containsKey('robotWrong')
        ? asT<String?>(json['robotWrong'])
        : null,
    agentService: json.containsKey('agentService')
        ? asT<String?>(json['agentService'])
        : null,
    networkWeek: json.containsKey('networkWeek')
        ? asT<String?>(json['networkWeek'])
        : null,
    optSuccess: json.containsKey('optSuccess')
        ? asT<String?>(json['optSuccess'])
        : null,
    connectError: json.containsKey('connectError')
        ? asT<String?>(json['connectError'])
        : null,
    noAgentOnline: json.containsKey('noAgentOnline')
        ? asT<String?>(json['noAgentOnline'])
        : null,
    uploadSuc: json.containsKey('uploadSuc')
        ? asT<String?>(json['uploadSuc'])
        : null,
    uploadErr: json.containsKey('uploadErr')
        ? asT<String?>(json['uploadErr'])
        : null,
    fileFail: json.containsKey('fileFail')
        ? asT<String?>(json['fileFail'])
        : null,
    positiveInt: json.containsKey('positiveInt')
        ? asT<String?>(json['positiveInt'])
        : null,
    date: json.containsKey('date') ? asT<String?>(json['date']) : null,
    time: json.containsKey('time') ? asT<String?>(json['time']) : null,
    link: json.containsKey('link') ? asT<String?>(json['link']) : null,
    int: json.containsKey('int') ? asT<String?>(json['int']) : null,
    pleaseChoice: json.containsKey('pleaseChoice')
        ? asT<String?>(json['pleaseChoice'])
        : null,
    noFill:
    json.containsKey('noFill') ? asT<String?>(json['noFill']) : null,
    wrongPhone: json.containsKey('WrongPhone')
        ? asT<String?>(json['WrongPhone'])
        : null,
    wrongLink: json.containsKey('WrongLink')
        ? asT<String?>(json['WrongLink'])
        : null,
    subSuc:
    json.containsKey('subSuc') ? asT<String?>(json['subSuc']) : null,
    subFail:
    json.containsKey('subFail') ? asT<String?>(json['subFail']) : null,
    customerForm: json.containsKey('customerForm')
        ? asT<String?>(json['customerForm'])
        : null,
    phoneForm: json.containsKey('phoneForm')
        ? asT<String?>(json['phoneForm'])
        : null,
    emailForm: json.containsKey('emailForm')
        ? asT<String?>(json['emailForm'])
        : null,
    fileError: json.containsKey('fileError')
        ? asT<String?>(json['fileError'])
        : null,
    fileGT:
    json.containsKey('fileGT') ? asT<String?>(json['fileGT']) : null,
    downloadLastChats: json.containsKey('downloadLastChats')
        ? asT<String?>(json['downloadLastChats'])
        : null,
    voice: json.containsKey('voice') ? asT<String?>(json['voice']) : null,
    reqError: json.containsKey('reqError')
        ? asT<String?>(json['reqError'])
        : null,
    sensitiveWords: json.containsKey('sensitiveWords')
        ? asT<String?>(json['sensitiveWords'])
        : null,
    placeInputHere: json.containsKey('placeInputHere')
        ? asT<String?>(json['placeInputHere'])
        : null,
    surveyRemarkRequire: json.containsKey('surveyRemarkRequire')
        ? asT<String?>(json['surveyRemarkRequire'])
        : null,
    contactUs: json.containsKey('contactUs')
        ? asT<String?>(json['contactUs'])
        : null,
    unreadMsgs: json.containsKey('unreadMsgs')
        ? asT<String?>(json['unreadMsgs'])
        : null,
    customerClose: json.containsKey('customerClose')
        ? asT<String?>(json['customerClose'])
        : null,
    closeChat: json.containsKey('closeChat')
        ? asT<String?>(json['closeChat'])
        : null,
    transferAgent: json.containsKey('transferAgent')
        ? asT<String?>(json['transferAgent'])
        : null,
    agentRequest: json.containsKey('agentRequest')
        ? asT<String?>(json['agentRequest'])
        : null,
    privacyPolicyError: json.containsKey('privacyPolicyError')
        ? asT<String?>(json['privacyPolicyError'])
        : null,
    httpCode429: json.containsKey('httpCode429')
        ? json['http-code-429'] == null
        ? null
        : HttpCode429.fromJson(
        asT<Map<String, dynamic>>(json['http-code-429'])!)
        : null,
    hasUnreadMsgs: json.containsKey('hasUnreadMsgs')
        ? asT<String?>(json['hasUnreadMsgs'])
        : null,
    askAudioPremission: json.containsKey('askAudioPremission')
        ? json['ask_audio_premission'] == null
        ? null
        : AskAudioPremission.fromJson(
        asT<Map<String, dynamic>>(json['ask_audio_premission'])!)
        : null,
  );

  String? closeSession;
  String? evaluationDialogue;
  String? rateService;
  String? surveyRemark;
  String? accessError;
  String? buttonHasExpired;
  String? unreadMessage;
  String? robotError;
  String? disconnect;
  String? agOffline;
  String? noAgent;
  String? forbid;
  String? forbidAdmin;
  String? logoutTip;
  String? connectFail;
  String? retry;
  String? reConnectFail;
  String? dataFail;
  String? success;
  String? fail;
  String? newMsg;
  String? newMsgTitle;
  String? chatOver;
  String? pleaseSurvey;
  String? transferSuccess;
  String? service;
  String? confirmClose;
  String? haveNotSurvey;
  String? stay;
  String? leave;
  String? selectOne;
  String? lastLevel;
  String? input;
  String? emailError;
  String? phoneError;
  String? phoneerror0;
  String? phoneerror1;
  String? phoneerror2;
  String? fmtError;
  String? validCode;
  String? reenter;
  String? historyMsg;
  String? noMoreMsg;
  String? moreMsg;
  String? seeMore;
  String? putItAway;
  String? overMaxLength;
  String? rq;
  String? agentTransferSuccess;
  String? please;
  String? download;
  String? downloadPlugin;
  String? downloadPlugin2;
  String? install;
  String? getCodeError;
  String? lessWords;
  String? saveFail;
  String? downloadFail;
  String? noMsgRecord;
  String? updateFlash;
  String? sendFail;
  String? overLimit;
  String? forbidType;
  String? overSize;
  String? uploadSuccess;
  String? overxm;
  String? uploadTip;
  String? uploadError;
  String? uploadErrorRetry;
  String? newError;
  String? wrongRequest;
  String? networkError;
  String? validRequest;
  String? robotWrong;
  String? agentService;
  String? networkWeek;
  String? optSuccess;
  String? connectError;
  String? noAgentOnline;
  String? uploadSuc;
  String? uploadErr;
  String? fileFail;
  String? positiveInt;
  String? date;
  String? time;
  String? link;
  String? int;
  String? pleaseChoice;
  String? noFill;
  String? wrongPhone;
  String? wrongLink;
  String? subSuc;
  String? subFail;
  String? customerForm;
  String? phoneForm;
  String? emailForm;
  String? fileError;
  String? fileGT;
  String? downloadLastChats;
  String? voice;
  String? reqError;
  String? sensitiveWords;
  String? placeInputHere;
  String? surveyRemarkRequire;
  String? contactUs;
  String? unreadMsgs;
  String? customerClose;
  String? closeChat;
  String? transferAgent;
  String? agentRequest;
  String? privacyPolicyError;
  HttpCode429? httpCode429;
  String? hasUnreadMsgs;
  AskAudioPremission? askAudioPremission;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'closeSession': closeSession,
    'evaluationDialogue': evaluationDialogue,
    'rateService': rateService,
    'surveyRemark': surveyRemark,
    'accessError': accessError,
    'button_has_expired': buttonHasExpired,
    'unreadMessage': unreadMessage,
    'robotError': robotError,
    'disconnect': disconnect,
    'agOffline': agOffline,
    'noAgent': noAgent,
    'forbid': forbid,
    'forbidAdmin': forbidAdmin,
    'logoutTip': logoutTip,
    'connectFail': connectFail,
    'retry': retry,
    'reConnectFail': reConnectFail,
    'dataFail': dataFail,
    'success': success,
    'fail': fail,
    'newMsg': newMsg,
    'newMsgTitle': newMsgTitle,
    'chatOver': chatOver,
    'pleaseSurvey': pleaseSurvey,
    'transferSuccess': transferSuccess,
    'service': service,
    'confirmClose': confirmClose,
    'haveNotSurvey': haveNotSurvey,
    'stay': stay,
    'leave': leave,
    'selectOne': selectOne,
    'lastLevel': lastLevel,
    'input': input,
    'emailError': emailError,
    'phoneError': phoneError,
    'phoneError-0': phoneerror0,
    'phoneError-1': phoneerror1,
    'phoneError-2': phoneerror2,
    'fmtError': fmtError,
    'validCode': validCode,
    'reenter': reenter,
    'historyMsg': historyMsg,
    'noMoreMsg': noMoreMsg,
    'moreMsg': moreMsg,
    'seeMore': seeMore,
    'putItAway': putItAway,
    'overMaxLength': overMaxLength,
    'rq': rq,
    'agentTransferSuccess': agentTransferSuccess,
    'please': please,
    'download': download,
    'downloadPlugin': downloadPlugin,
    'downloadPlugin2': downloadPlugin2,
    'install': install,
    'getCodeError': getCodeError,
    'lessWords': lessWords,
    'saveFail': saveFail,
    'downloadFail': downloadFail,
    'noMsgRecord': noMsgRecord,
    'updateFlash': updateFlash,
    'sendFail': sendFail,
    'overLimit': overLimit,
    'forbidType': forbidType,
    'overSize': overSize,
    'uploadSuccess': uploadSuccess,
    'overxm': overxm,
    'upload_tip': uploadTip,
    'uploadError': uploadError,
    'uploadErrorRetry': uploadErrorRetry,
    'newError': newError,
    'wrongRequest': wrongRequest,
    'networkError': networkError,
    'validRequest': validRequest,
    'robotWrong': robotWrong,
    'agentService': agentService,
    'networkWeek': networkWeek,
    'optSuccess': optSuccess,
    'connectError': connectError,
    'noAgentOnline': noAgentOnline,
    'uploadSuc': uploadSuc,
    'uploadErr': uploadErr,
    'fileFail': fileFail,
    'positiveInt': positiveInt,
    'date': date,
    'time': time,
    'link': link,
    'int': int,
    'pleaseChoice': pleaseChoice,
    'noFill': noFill,
    'WrongPhone': wrongPhone,
    'WrongLink': wrongLink,
    'subSuc': subSuc,
    'subFail': subFail,
    'customerForm': customerForm,
    'phoneForm': phoneForm,
    'emailForm': emailForm,
    'fileError': fileError,
    'fileGT': fileGT,
    'downloadLastChats': downloadLastChats,
    'voice': voice,
    'reqError': reqError,
    'sensitiveWords': sensitiveWords,
    'placeInputHere': placeInputHere,
    'surveyRemarkRequire': surveyRemarkRequire,
    'contactUs': contactUs,
    'unreadMsgs': unreadMsgs,
    'customerClose': customerClose,
    'closeChat': closeChat,
    'transferAgent': transferAgent,
    'agentRequest': agentRequest,
    'privacyPolicyError': privacyPolicyError,
    'http-code-429': httpCode429,
    'hasUnreadMsgs': hasUnreadMsgs,
    'ask_audio_premission': askAudioPremission,
  };
}

class HttpCode429 {
  HttpCode429({
    this.title,
    this.tip1,
    this.tip2,
    this.tip3,
  });

  factory HttpCode429.fromJson(Map<String, dynamic> json) => HttpCode429(
    title: json.containsKey('title') ? asT<String?>(json['title']) : null,
    tip1: json.containsKey('tip-1') ? asT<String?>(json['tip-1']) : null,
    tip2: json.containsKey('tip-2') ? asT<String?>(json['tip-2']) : null,
    tip3: json.containsKey('tip-3') ? asT<String?>(json['tip-3']) : null,
  );

  String? title;
  String? tip1;
  String? tip2;
  String? tip3;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'tip-1': tip1,
    'tip-2': tip2,
    'tip-3': tip3,
  };
}

class AskAudioPremission {
  AskAudioPremission({
    this.userReject,
    this.requestpermissionFail,
    this.noPermission,
  });

  factory AskAudioPremission.fromJson(Map<String, dynamic> json) =>
      AskAudioPremission(
        userReject: json.containsKey('user_reject')
            ? asT<String?>(json['user_reject'])
            : null,
        requestpermissionFail: json.containsKey('requestPermission_fail')
            ? asT<String?>(json['requestPermission_fail'])
            : null,
        noPermission: json.containsKey('no_permission')
            ? asT<String?>(json['no_permission'])
            : null,
      );

  String? userReject;
  String? requestpermissionFail;
  String? noPermission;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'user_reject': userReject,
    'requestPermission_fail': requestpermissionFail,
    'no_permission': noPermission,
  };
}

class Label {
  Label({
    this.prompt,
    this.download,
    this.preview,
    this.emoji,
    this.evaluation,
    this.hasEvaluation,
    this.survey,
    this.refresh,
    this.submit,
    this.upload,
    this.send,
    this.leaveMsg,
    this.copyRight,
    this.notify,
    this.camera,
    this.scanTheCode,
    this.video1,
    this.file,
    this.image,
    this.sure,
    this.system,
    this.connecting,
    this.consulting,
    this.official,
    this.satisfaction,
    this.evaluating,
    this.withdrawed,
    this.screenshot,
    this.call,
    this.formMsg,
    this.structMsg,
    this.audio,
    this.video,
    this.cancel,
    this.verifiyCode,
    this.invisibility,
    this.changeASheet,
    this.inputting,
    this.msgLog,
    this.viewMsgLog,
    this.required1674461345239000,
    this.sendImage,
    this.minimize,
    this.mesagePromptSound,
    this.tell,
    this.openFali,
    this.enterVoice,
    this.enterStart,
    this.leaveEnd,
    this.waitTurn,
    this.notSupportTip,
    this.voiceTimeLimit,
    this.voiceTooShort,
    this.voiceTruning,
    this.voiceTrunText,
    this.reTrySubmit,
    this.know,
    this.submitSuccess,
    this.surveySubmitSuccess,
    this.submitSuccessTip,
    this.submitError,
    this.submitErrorTip,
    this.read,
    this.unread,
    this.close,
    this.chatEnd,
    this.satisfied,
    this.dissatisfied,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    prompt:
    json.containsKey('prompt') ? asT<String?>(json['prompt']) : null,
    download: json.containsKey('download')
        ? asT<String?>(json['download'])
        : null,
    preview:
    json.containsKey('preview') ? asT<String?>(json['preview']) : null,
    emoji: json.containsKey('emoji') ? asT<String?>(json['emoji']) : null,
    evaluation: json.containsKey('evaluation')
        ? asT<String?>(json['evaluation'])
        : null,
    hasEvaluation: json.containsKey('hasEvaluation')
        ? asT<String?>(json['hasEvaluation'])
        : null,
    survey:
    json.containsKey('survey') ? asT<String?>(json['survey']) : null,
    refresh:
    json.containsKey('refresh') ? asT<String?>(json['refresh']) : null,
    submit:
    json.containsKey('submit') ? asT<String?>(json['submit']) : null,
    upload:
    json.containsKey('upload') ? asT<String?>(json['upload']) : null,
    send: json.containsKey('send') ? asT<String?>(json['send']) : null,
    leaveMsg: json.containsKey('leaveMsg')
        ? asT<String?>(json['leaveMsg'])
        : null,
    copyRight: json.containsKey('copyRight')
        ? asT<String?>(json['copyRight'])
        : null,
    notify:
    json.containsKey('notify') ? asT<String?>(json['notify']) : null,
    camera:
    json.containsKey('camera') ? asT<String?>(json['camera']) : null,
    scanTheCode: json.containsKey('scanTheCode')
        ? asT<String?>(json['scanTheCode'])
        : null,
    video1:
    json.containsKey('video1') ? asT<String?>(json['video1']) : null,
    file: json.containsKey('file') ? asT<String?>(json['file']) : null,
    image: json.containsKey('image') ? asT<String?>(json['image']) : null,
    sure: json.containsKey('sure') ? asT<String?>(json['sure']) : null,
    system:
    json.containsKey('system') ? asT<String?>(json['system']) : null,
    connecting: json.containsKey('connecting')
        ? asT<String?>(json['connecting'])
        : null,
    consulting: json.containsKey('consulting')
        ? asT<String?>(json['consulting'])
        : null,
    official: json.containsKey('official')
        ? asT<String?>(json['official'])
        : null,
    satisfaction: json.containsKey('satisfaction')
        ? asT<String?>(json['satisfaction'])
        : null,
    evaluating: json.containsKey('evaluating')
        ? asT<String?>(json['evaluating'])
        : null,
    withdrawed: json.containsKey('withdrawed')
        ? asT<String?>(json['withdrawed'])
        : null,
    screenshot: json.containsKey('screenshot')
        ? asT<String?>(json['screenshot'])
        : null,
    call: json.containsKey('call') ? asT<String?>(json['call']) : null,
    formMsg:
    json.containsKey('formMsg') ? asT<String?>(json['formMsg']) : null,
    structMsg: json.containsKey('structMsg')
        ? asT<String?>(json['structMsg'])
        : null,
    audio: json.containsKey('audio') ? asT<String?>(json['audio']) : null,
    video: json.containsKey('video') ? asT<String?>(json['video']) : null,
    cancel:
    json.containsKey('cancel') ? asT<String?>(json['cancel']) : null,
    verifiyCode: json.containsKey('verifiyCode')
        ? asT<String?>(json['verifiyCode'])
        : null,
    invisibility: json.containsKey('invisibility')
        ? asT<String?>(json['invisibility'])
        : null,
    changeASheet: json.containsKey('changeASheet')
        ? asT<String?>(json['changeASheet'])
        : null,
    inputting: json.containsKey('inputting')
        ? asT<String?>(json['inputting'])
        : null,
    msgLog:
    json.containsKey('msgLog') ? asT<String?>(json['msgLog']) : null,
    viewMsgLog: json.containsKey('viewMsgLog')
        ? asT<String?>(json['viewMsgLog'])
        : null,
    required1674461345239000: json.containsKey('required')
        ? asT<String?>(json['required'])
        : null,
    sendImage: json.containsKey('sendImage')
        ? asT<String?>(json['sendImage'])
        : null,
    minimize: json.containsKey('minimize')
        ? asT<String?>(json['minimize'])
        : null,
    mesagePromptSound: json.containsKey('mesagePromptSound')
        ? asT<String?>(json['mesagePromptSound'])
        : null,
    tell: json.containsKey('tell') ? asT<String?>(json['tell']) : null,
    openFali: json.containsKey('openFali')
        ? asT<String?>(json['openFali'])
        : null,
    enterVoice: json.containsKey('enterVoice')
        ? asT<String?>(json['enterVoice'])
        : null,
    enterStart: json.containsKey('enterStart')
        ? asT<String?>(json['enterStart'])
        : null,
    leaveEnd: json.containsKey('leaveEnd')
        ? asT<String?>(json['leaveEnd'])
        : null,
    waitTurn: json.containsKey('waitTurn')
        ? asT<String?>(json['waitTurn'])
        : null,
    notSupportTip: json.containsKey('notSupportTip')
        ? asT<String?>(json['notSupportTip'])
        : null,
    voiceTimeLimit: json.containsKey('voiceTimeLimit')
        ? asT<String?>(json['voiceTimeLimit'])
        : null,
    voiceTooShort: json.containsKey('voiceTooShort')
        ? asT<String?>(json['voiceTooShort'])
        : null,
    voiceTruning: json.containsKey('voiceTruning')
        ? asT<String?>(json['voiceTruning'])
        : null,
    voiceTrunText: json.containsKey('voiceTrunText')
        ? asT<String?>(json['voiceTrunText'])
        : null,
    reTrySubmit: json.containsKey('reTrySubmit')
        ? asT<String?>(json['reTrySubmit'])
        : null,
    know: json.containsKey('know') ? asT<String?>(json['know']) : null,
    submitSuccess: json.containsKey('submitSuccess')
        ? asT<String?>(json['submitSuccess'])
        : null,
    surveySubmitSuccess: json.containsKey('surveySubmitSuccess')
        ? asT<String?>(json['surveySubmitSuccess'])
        : null,
    submitSuccessTip: json.containsKey('submitSuccessTip')
        ? asT<String?>(json['submitSuccessTip'])
        : null,
    submitError: json.containsKey('submitError')
        ? asT<String?>(json['submitError'])
        : null,
    submitErrorTip: json.containsKey('submitErrorTip')
        ? asT<String?>(json['submitErrorTip'])
        : null,
    read: json.containsKey('read') ? asT<String?>(json['read']) : null,
    unread:
    json.containsKey('unread') ? asT<String?>(json['unread']) : null,
    close: json.containsKey('close') ? asT<String?>(json['close']) : null,
    chatEnd:
    json.containsKey('chatEnd') ? asT<String?>(json['chatEnd']) : null,
    satisfied: json.containsKey('satisfied')
        ? asT<String?>(json['satisfied'])
        : null,
    dissatisfied: json.containsKey('dissatisfied')
        ? asT<String?>(json['dissatisfied'])
        : null,
  );

  String? prompt;
  String? download;
  String? preview;
  String? emoji;
  String? evaluation;
  String? hasEvaluation;
  String? survey;
  String? refresh;
  String? submit;
  String? upload;
  String? send;
  String? leaveMsg;
  String? copyRight;
  String? notify;
  String? camera;
  String? scanTheCode;
  String? video1;
  String? file;
  String? image;
  String? sure;
  String? system;
  String? connecting;
  String? consulting;
  String? official;
  String? satisfaction;
  String? evaluating;
  String? withdrawed;
  String? screenshot;
  String? call;
  String? formMsg;
  String? structMsg;
  String? audio;
  String? video;
  String? cancel;
  String? verifiyCode;
  String? invisibility;
  String? changeASheet;
  String? inputting;
  String? msgLog;
  String? viewMsgLog;
  String? required1674461345239000;
  String? sendImage;
  String? minimize;
  String? mesagePromptSound;
  String? tell;
  String? openFali;
  String? enterVoice;
  String? enterStart;
  String? leaveEnd;
  String? waitTurn;
  String? notSupportTip;
  String? voiceTimeLimit;
  String? voiceTooShort;
  String? voiceTruning;
  String? voiceTrunText;
  String? reTrySubmit;
  String? know;
  String? submitSuccess;
  String? surveySubmitSuccess;
  String? submitSuccessTip;
  String? submitError;
  String? submitErrorTip;
  String? read;
  String? unread;
  String? close;
  String? chatEnd;
  String? satisfied;
  String? dissatisfied;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'prompt': prompt,
    'download': download,
    'preview': preview,
    'emoji': emoji,
    'evaluation': evaluation,
    'hasEvaluation': hasEvaluation,
    'survey': survey,
    'refresh': refresh,
    'submit': submit,
    'upload': upload,
    'send': send,
    'leaveMsg': leaveMsg,
    'copyRight': copyRight,
    'notify': notify,
    'camera': camera,
    'scanTheCode': scanTheCode,
    'video1': video1,
    'file': file,
    'image': image,
    'sure': sure,
    'system': system,
    'connecting': connecting,
    'consulting': consulting,
    'official': official,
    'satisfaction': satisfaction,
    'evaluating': evaluating,
    'withdrawed': withdrawed,
    'screenshot': screenshot,
    'call': call,
    'formMsg': formMsg,
    'structMsg': structMsg,
    'audio': audio,
    'video': video,
    'cancel': cancel,
    'verifiyCode': verifiyCode,
    'invisibility': invisibility,
    'changeASheet': changeASheet,
    'inputting': inputting,
    'msgLog': msgLog,
    'viewMsgLog': viewMsgLog,
    'required': required1674461345239000,
    'sendImage': sendImage,
    'minimize': minimize,
    'mesagePromptSound': mesagePromptSound,
    'tell': tell,
    'openFali': openFali,
    'enterVoice': enterVoice,
    'enterStart': enterStart,
    'leaveEnd': leaveEnd,
    'waitTurn': waitTurn,
    'notSupportTip': notSupportTip,
    'voiceTimeLimit': voiceTimeLimit,
    'voiceTooShort': voiceTooShort,
    'voiceTruning': voiceTruning,
    'voiceTrunText': voiceTrunText,
    'reTrySubmit': reTrySubmit,
    'know': know,
    'submitSuccess': submitSuccess,
    'surveySubmitSuccess': surveySubmitSuccess,
    'submitSuccessTip': submitSuccessTip,
    'submitError': submitError,
    'submitErrorTip': submitErrorTip,
    'read': read,
    'unread': unread,
    'close': close,
    'chatEnd': chatEnd,
    'satisfied': satisfied,
    'dissatisfied': dissatisfied,
  };
}

class FeedbackTab {
  FeedbackTab({
    this.noResultMsg,
    this.success,
    this.ready,
    this.udeskIcon,
    this.nickName,
    this.email,
    this.cellphone,
    this.searchKnowledge,
    this.helpText,
    this.noHelpText,
    this.showResult,
    this.result,
    this.search,
  });

  factory FeedbackTab.fromJson(Map<String, dynamic> json) => FeedbackTab(
    noResultMsg: json.containsKey('noResultMsg')
        ? asT<String?>(json['noResultMsg'])
        : null,
    success:
    json.containsKey('success') ? asT<String?>(json['success']) : null,
    ready: json.containsKey('ready') ? asT<String?>(json['ready']) : null,
    udeskIcon: json.containsKey('udeskIcon')
        ? asT<String?>(json['udeskIcon'])
        : null,
    nickName: json.containsKey('nick_name')
        ? asT<String?>(json['nick_name'])
        : null,
    email: json.containsKey('email') ? asT<String?>(json['email']) : null,
    cellphone: json.containsKey('cellphone')
        ? asT<String?>(json['cellphone'])
        : null,
    searchKnowledge: json.containsKey('searchKnowledge')
        ? asT<String?>(json['searchKnowledge'])
        : null,
    helpText: json.containsKey('helpText')
        ? asT<String?>(json['helpText'])
        : null,
    noHelpText: json.containsKey('noHelpText')
        ? asT<String?>(json['noHelpText'])
        : null,
    showResult: json.containsKey('showResult')
        ? asT<String?>(json['showResult'])
        : null,
    result:
    json.containsKey('result') ? asT<String?>(json['result']) : null,
    search:
    json.containsKey('search') ? asT<String?>(json['search']) : null,
  );

  String? noResultMsg;
  String? success;
  String? ready;
  String? udeskIcon;
  String? nickName;
  String? email;
  String? cellphone;
  String? searchKnowledge;
  String? helpText;
  String? noHelpText;
  String? showResult;
  String? result;
  String? search;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'noResultMsg': noResultMsg,
    'success': success,
    'ready': ready,
    'udeskIcon': udeskIcon,
    'nick_name': nickName,
    'email': email,
    'cellphone': cellphone,
    'searchKnowledge': searchKnowledge,
    'helpText': helpText,
    'noHelpText': noHelpText,
    'showResult': showResult,
    'result': result,
    'search': search,
  };
}

class Vcall {
  Vcall({
    this.to,
    this.accept,
    this.danger,
    this.hangup,
    this.videoChat,
    this.audioChat,
    this.ringingDesc,
    this.chatTitle,
  });

  factory Vcall.fromJson(Map<String, dynamic> json) => Vcall(
    to: json.containsKey('to') ? asT<String?>(json['to']) : null,
    accept:
    json.containsKey('accept') ? asT<String?>(json['accept']) : null,
    danger:
    json.containsKey('danger') ? asT<String?>(json['danger']) : null,
    hangup:
    json.containsKey('hangup') ? asT<String?>(json['hangup']) : null,
    videoChat: json.containsKey('videoChat')
        ? asT<String?>(json['videoChat'])
        : null,
    audioChat: json.containsKey('audioChat')
        ? asT<String?>(json['audioChat'])
        : null,
    ringingDesc: json.containsKey('ringing_desc')
        ? asT<String?>(json['ringing_desc'])
        : null,
    chatTitle: json.containsKey('chat_title')
        ? asT<String?>(json['chat_title'])
        : null,
  );

  String? to;
  String? accept;
  String? danger;
  String? hangup;
  String? videoChat;
  String? audioChat;
  String? ringingDesc;
  String? chatTitle;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'to': to,
    'accept': accept,
    'danger': danger,
    'hangup': hangup,
    'videoChat': videoChat,
    'audioChat': audioChat,
    'ringing_desc': ringingDesc,
    'chat_title': chatTitle,
  };
}

class Ticket {
  Ticket({
    this.name,
    this.inputPlaceholder,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    name: json.containsKey('name') ? asT<String?>(json['name']) : null,
    inputPlaceholder: json.containsKey('inputPlaceholder')
        ? asT<String?>(json['inputPlaceholder'])
        : null,
  );

  String? name;
  String? inputPlaceholder;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'inputPlaceholder': inputPlaceholder,
  };
}

class Event {
  Event({
    this.videoCallInvitation,
    this.videoCallInvitationAccept,
    this.videoCallInvitationDeny,
    this.videoCallInvitationCancel,
    this.voiceCallInvitation,
    this.voiceCallInvitationAccept,
    this.voiceCallInvitationDeny,
    this.voiceCallInvitationCancel,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    videoCallInvitation: json.containsKey('video_call_invitation')
        ? asT<String?>(json['video_call_invitation'])
        : null,
    videoCallInvitationAccept:
    json.containsKey('video_call_invitation_accept')
        ? asT<String?>(json['video_call_invitation_accept'])
        : null,
    videoCallInvitationDeny: json.containsKey('video_call_invitation_deny')
        ? asT<String?>(json['video_call_invitation_deny'])
        : null,
    videoCallInvitationCancel:
    json.containsKey('video_call_invitation_cancel')
        ? asT<String?>(json['video_call_invitation_cancel'])
        : null,
    voiceCallInvitation: json.containsKey('voice_call_invitation')
        ? asT<String?>(json['voice_call_invitation'])
        : null,
    voiceCallInvitationAccept:
    json.containsKey('voice_call_invitation_accept')
        ? asT<String?>(json['voice_call_invitation_accept'])
        : null,
    voiceCallInvitationDeny: json.containsKey('voice_call_invitation_deny')
        ? asT<String?>(json['voice_call_invitation_deny'])
        : null,
    voiceCallInvitationCancel:
    json.containsKey('voice_call_invitation_cancel')
        ? asT<String?>(json['voice_call_invitation_cancel'])
        : null,
  );

  String? videoCallInvitation;
  String? videoCallInvitationAccept;
  String? videoCallInvitationDeny;
  String? videoCallInvitationCancel;
  String? voiceCallInvitation;
  String? voiceCallInvitationAccept;
  String? voiceCallInvitationDeny;
  String? voiceCallInvitationCancel;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'video_call_invitation': videoCallInvitation,
    'video_call_invitation_accept': videoCallInvitationAccept,
    'video_call_invitation_deny': videoCallInvitationDeny,
    'video_call_invitation_cancel': videoCallInvitationCancel,
    'voice_call_invitation': voiceCallInvitation,
    'voice_call_invitation_accept': voiceCallInvitationAccept,
    'voice_call_invitation_deny': voiceCallInvitationDeny,
    'voice_call_invitation_cancel': voiceCallInvitationCancel,
  };
}

class Components {
  Components({
    this.agentSelect,
    this.chatAgent,
    this.chatLog,
    this.chatRobot,
    this.feedback,
    this.index,
    this.lib,
    this.merchant,
    this.ticket,
    this.udeskFeedback,
    this.ui,
  });

  factory Components.fromJson(Map<String, dynamic> json) => Components(
    agentSelect: json.containsKey('agentSelect')
        ? json['agent_select'] == null
        ? null
        : AgentSelect.fromJson(
        asT<Map<String, dynamic>>(json['agent_select'])!)
        : null,
    chatAgent: json.containsKey('chatAgent')
        ? json['chatAgent'] == null
        ? null
        : ChatAgent.fromJson(
        asT<Map<String, dynamic>>(json['chatAgent'])!)
        : null,
    chatLog: json.containsKey('chatLog')
        ? json['chatLog'] == null
        ? null
        : ChatLog.fromJson(asT<Map<String, dynamic>>(json['chatLog'])!)
        : null,
    chatRobot: json.containsKey('chatRobot')
        ? json['chatRobot'] == null
        ? null
        : ChatRobot.fromJson(
        asT<Map<String, dynamic>>(json['chatRobot'])!)
        : null,
    feedback: json.containsKey('feedback')
        ? json['feedback'] == null
        ? null
        : Feedback4156.fromJson(
        asT<Map<String, dynamic>>(json['feedback'])!)
        : null,
    index: json.containsKey('index')
        ? json['index'] == null
        ? null
        : Index.fromJson(asT<Map<String, dynamic>>(json['index'])!)
        : null,
    lib: json.containsKey('lib')
        ? json['lib'] == null
        ? null
        : Lib.fromJson(asT<Map<String, dynamic>>(json['lib'])!)
        : null,
    merchant: json.containsKey('merchant')
        ? json['merchant'] == null
        ? null
        : Merchant.fromJson(
        asT<Map<String, dynamic>>(json['merchant'])!)
        : null,
    ticket: json.containsKey('ticket')
        ? json['ticket'] == null
        ? null
        : TicketData.fromJson(
        asT<Map<String, dynamic>>(json['ticket'])!)
        : null,
    udeskFeedback: json.containsKey('udeskFeedback')
        ? json['udesk_feedback'] == null
        ? null
        : UdeskFeedback.fromJson(
        asT<Map<String, dynamic>>(json['udesk_feedback'])!)
        : null,
    ui: json.containsKey('ui')
        ? json['ui'] == null
        ? null
        : Ui.fromJson(asT<Map<String, dynamic>>(json['ui'])!)
        : null,
  );

  AgentSelect? agentSelect;
  ChatAgent? chatAgent;
  ChatLog? chatLog;
  ChatRobot? chatRobot;
  Feedback4156? feedback;
  Index? index;
  Lib? lib;
  Merchant? merchant;
  TicketData? ticket;
  UdeskFeedback? udeskFeedback;
  Ui? ui;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'agent_select': agentSelect,
    'chatAgent': chatAgent,
    'chatLog': chatLog,
    'chatRobot': chatRobot,
    'feedback': feedback,
    'index': index,
    'lib': lib,
    'merchant': merchant,
    'ticket': ticket,
    'udesk_feedback': udeskFeedback,
    'ui': ui,
  };
}

class AgentSelect {
  AgentSelect({
    this.online,
    this.offline,
    this.beBusy,
    this.conversationbutton,
    this.youHaveCon18PleaseExit,
    this.interfaceErrorPleaseTryAgain,
    this.theCurrent16sNotOnline,
    this.requestErrorPleaseTryAgain,
    this.pleaseOpen13hatBrowser,
  });

  factory AgentSelect.fromJson(Map<String, dynamic> json) => AgentSelect(
    online:
    json.containsKey('online') ? asT<String?>(json['online']) : null,
    offline:
    json.containsKey('offline') ? asT<String?>(json['offline']) : null,
    beBusy:
    json.containsKey('beBusy') ? asT<String?>(json['beBusy']) : null,
    conversationbutton: json.containsKey('Conversationbutton')
        ? asT<String?>(json['Conversationbutton'])
        : null,
    youHaveCon18PleaseExit: json.containsKey('youHaveCon18PleaseExit')
        ? asT<String?>(json['youHaveCon18PleaseExit'])
        : null,
    interfaceErrorPleaseTryAgain:
    json.containsKey('interfaceErrorPleaseTryAgain')
        ? asT<String?>(json['interfaceErrorPleaseTryAgain'])
        : null,
    theCurrent16sNotOnline: json.containsKey('theCurrent16sNotOnline')
        ? asT<String?>(json['theCurrent16sNotOnline'])
        : null,
    requestErrorPleaseTryAgain:
    json.containsKey('requestErrorPleaseTryAgain')
        ? asT<String?>(json['requestErrorPleaseTryAgain'])
        : null,
    pleaseOpen13hatBrowser: json.containsKey('pleaseOpen13hatBrowser')
        ? asT<String?>(json['pleaseOpen13hatBrowser'])
        : null,
  );

  String? online;
  String? offline;
  String? beBusy;
  String? conversationbutton;
  String? youHaveCon18PleaseExit;
  String? interfaceErrorPleaseTryAgain;
  String? theCurrent16sNotOnline;
  String? requestErrorPleaseTryAgain;
  String? pleaseOpen13hatBrowser;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'online': online,
    'offline': offline,
    'beBusy': beBusy,
    'Conversationbutton': conversationbutton,
    'youHaveCon18PleaseExit': youHaveCon18PleaseExit,
    'interfaceErrorPleaseTryAgain': interfaceErrorPleaseTryAgain,
    'theCurrent16sNotOnline': theCurrent16sNotOnline,
    'requestErrorPleaseTryAgain': requestErrorPleaseTryAgain,
    'pleaseOpen13hatBrowser': pleaseOpen13hatBrowser,
  };
}

class ChatAgent {
  ChatAgent({
    this.streamManagementError,
    this.collectThe12connection,
    this.initiateAVideoCall,
    this.towards,
    this.initiateAnAudioCall,
    this.failedToOpenAudioAndVideoCall,
    this.accept,
    this.refuse,
    this.pStylecolo67ansferring,
    this.articlep,
    this.receiptNo,
    this.failedToLo23ndTryAgain,
    this.queuePageCanSendUpToMessages,
    this.sendingToo19AgainLater,
    this.failedToSendVoiceMessage,
    this.acceptTheM15TheProduct,
    this.determine,
    this.cancel,
    this.incorrectFillingFormatOf,
  });

  factory ChatAgent.fromJson(Map<String, dynamic> json) => ChatAgent(
    streamManagementError: json.containsKey('streamManagementError')
        ? asT<String?>(json['streamManagementError'])
        : null,
    collectThe12connection: json.containsKey('collectThe12connection')
        ? asT<String?>(json['collectThe12connection'])
        : null,
    initiateAVideoCall: json.containsKey('initiateAVideoCall')
        ? asT<String?>(json['initiateAVideoCall'])
        : null,
    towards:
    json.containsKey('towards') ? asT<String?>(json['towards']) : null,
    initiateAnAudioCall: json.containsKey('initiateAnAudioCall')
        ? asT<String?>(json['initiateAnAudioCall'])
        : null,
    failedToOpenAudioAndVideoCall:
    json.containsKey('failedToOpenAudioAndVideoCall')
        ? asT<String?>(json['failedToOpenAudioAndVideoCall'])
        : null,
    accept:
    json.containsKey('accept') ? asT<String?>(json['accept']) : null,
    refuse:
    json.containsKey('refuse') ? asT<String?>(json['refuse']) : null,
    pStylecolo67ansferring: json.containsKey('pStylecolo67ansferring')
        ? asT<String?>(json['pStylecolo67ansferring'])
        : null,
    articlep: json.containsKey('articlep')
        ? asT<String?>(json['articlep'])
        : null,
    receiptNo: json.containsKey('ReceiptNo')
        ? asT<String?>(json['ReceiptNo'])
        : null,
    failedToLo23ndTryAgain: json.containsKey('failedToLo23ndTryAgain')
        ? asT<String?>(json['failedToLo23ndTryAgain'])
        : null,
    queuePageCanSendUpToMessages:
    json.containsKey('queuePageCanSendUpToMessages')
        ? asT<String?>(json['queuePageCanSendUpToMessages'])
        : null,
    sendingToo19AgainLater: json.containsKey('sendingToo19AgainLater')
        ? asT<String?>(json['sendingToo19AgainLater'])
        : null,
    failedToSendVoiceMessage: json.containsKey('failedToSendVoiceMessage')
        ? asT<String?>(json['failedToSendVoiceMessage'])
        : null,
    acceptTheM15TheProduct: json.containsKey('acceptTheM15TheProduct')
        ? asT<String?>(json['acceptTheM15TheProduct'])
        : null,
    determine: json.containsKey('determine')
        ? asT<String?>(json['determine'])
        : null,
    cancel:
    json.containsKey('cancel') ? asT<String?>(json['cancel']) : null,
    incorrectFillingFormatOf: json.containsKey('incorrectFillingFormatOf')
        ? asT<String?>(json['incorrectFillingFormatOf'])
        : null,
  );

  String? streamManagementError;
  String? collectThe12connection;
  String? initiateAVideoCall;
  String? towards;
  String? initiateAnAudioCall;
  String? failedToOpenAudioAndVideoCall;
  String? accept;
  String? refuse;
  String? pStylecolo67ansferring;
  String? articlep;
  String? receiptNo;
  String? failedToLo23ndTryAgain;
  String? queuePageCanSendUpToMessages;
  String? sendingToo19AgainLater;
  String? failedToSendVoiceMessage;
  String? acceptTheM15TheProduct;
  String? determine;
  String? cancel;
  String? incorrectFillingFormatOf;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'streamManagementError': streamManagementError,
    'collectThe12connection': collectThe12connection,
    'initiateAVideoCall': initiateAVideoCall,
    'towards': towards,
    'initiateAnAudioCall': initiateAnAudioCall,
    'failedToOpenAudioAndVideoCall': failedToOpenAudioAndVideoCall,
    'accept': accept,
    'refuse': refuse,
    'pStylecolo67ansferring': pStylecolo67ansferring,
    'articlep': articlep,
    'ReceiptNo': receiptNo,
    'failedToLo23ndTryAgain': failedToLo23ndTryAgain,
    'queuePageCanSendUpToMessages': queuePageCanSendUpToMessages,
    'sendingToo19AgainLater': sendingToo19AgainLater,
    'failedToSendVoiceMessage': failedToSendVoiceMessage,
    'acceptTheM15TheProduct': acceptTheM15TheProduct,
    'determine': determine,
    'cancel': cancel,
    'incorrectFillingFormatOf': incorrectFillingFormatOf,
  };
}

class ChatLog {
  ChatLog({
    this.messageRecordIsEmpty,
  });

  factory ChatLog.fromJson(Map<String, dynamic> json) => ChatLog(
    messageRecordIsEmpty: json.containsKey('messageRecordIsEmpty')
        ? asT<String?>(json['messageRecordIsEmpty'])
        : null,
  );

  String? messageRecordIsEmpty;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'messageRecordIsEmpty': messageRecordIsEmpty,
  };
}

class ChatRobot {
  ChatRobot({
    this.thankYouFo106ualService,
    this.clickSubmitFormadiv,
    this.divClickaC16DataIframe,
    this.submitTheWorkOrderadiv,
    this.clickEnter,
    this.ticketQuery,
    this.switch1674461345561000,
    this.failedToDeliverBusinessRecords,
    this.buttonClas23tlasbutton,
    this.theButtonH17ainItAgain,
    this.pleaseGive13sThanWords,
    this.classcardV25eSelectdiv,
    this.spanClasst39lutionspan,
    this.spanClasst31Solvedspan,
    this.spanClasst27Enablespan,
    this.spanClasst29Closedspan,
    this.detailstd,
    this.divNumbernbsp,
    this.divClassti49ightdivdiv,
    this.thStylepaddingLeftpxNumberth,
    this.thWidthTitleth,
    this.thWidthWorkOrderStatusth,
    this.thWidthCreationTimeth,
    this.thOperationth,
    this.divReturndiv,
    this.workOrderQuery,
    this.divClassti92ailsdivdiv,
    this.detailsOfCommunication,
    this.collectCommunicationDetails,
    this.robot,
  });

  factory ChatRobot.fromJson(Map<String, dynamic> json) => ChatRobot(
    thankYouFo106ualService: json.containsKey('thankYouFo106ualService')
        ? asT<String?>(json['thankYouFo106ualService'])
        : null,
    clickSubmitFormadiv: json.containsKey('ClickSubmitFormadiv')
        ? asT<String?>(json['ClickSubmitFormadiv'])
        : null,
    divClickaC16DataIframe: json.containsKey('divClickaC16DataIframe')
        ? asT<String?>(json['divClickaC16DataIframe'])
        : null,
    submitTheWorkOrderadiv: json.containsKey('SubmitTheWorkOrderadiv')
        ? asT<String?>(json['SubmitTheWorkOrderadiv'])
        : null,
    clickEnter: json.containsKey('click_enter')
        ? asT<String?>(json['click_enter'])
        : null,
    ticketQuery: json.containsKey('ticket_query')
        ? asT<String?>(json['ticket_query'])
        : null,
    switch1674461345561000:
    json.containsKey('switch') ? asT<String?>(json['switch']) : null,
    failedToDeliverBusinessRecords:
    json.containsKey('failedToDeliverBusinessRecords')
        ? asT<String?>(json['failedToDeliverBusinessRecords'])
        : null,
    buttonClas23tlasbutton: json.containsKey('buttonClas23tlasbutton')
        ? asT<String?>(json['buttonClas23tlasbutton'])
        : null,
    theButtonH17ainItAgain: json.containsKey('theButtonH17ainItAgain')
        ? asT<String?>(json['theButtonH17ainItAgain'])
        : null,
    pleaseGive13sThanWords: json.containsKey('pleaseGive13sThanWords')
        ? asT<String?>(json['pleaseGive13sThanWords'])
        : null,
    classcardV25eSelectdiv: json.containsKey('classcardV25eSelectdiv')
        ? asT<String?>(json['classcardV25eSelectdiv'])
        : null,
    spanClasst39lutionspan: json.containsKey('spanClasst39lutionspan')
        ? asT<String?>(json['spanClasst39lutionspan'])
        : null,
    spanClasst31Solvedspan: json.containsKey('spanClasst31Solvedspan')
        ? asT<String?>(json['spanClasst31Solvedspan'])
        : null,
    spanClasst27Enablespan: json.containsKey('spanClasst27Enablespan')
        ? asT<String?>(json['spanClasst27Enablespan'])
        : null,
    spanClasst29Closedspan: json.containsKey('spanClasst29Closedspan')
        ? asT<String?>(json['spanClasst29Closedspan'])
        : null,
    detailstd: json.containsKey('Detailstd')
        ? asT<String?>(json['Detailstd'])
        : null,
    divNumbernbsp: json.containsKey('divNumbernbsp')
        ? asT<String?>(json['divNumbernbsp'])
        : null,
    divClassti49ightdivdiv: json.containsKey('divClassti49ightdivdiv')
        ? asT<String?>(json['divClassti49ightdivdiv'])
        : null,
    thStylepaddingLeftpxNumberth:
    json.containsKey('thStylepaddingLeftpxNumberth')
        ? asT<String?>(json['thStylepaddingLeftpxNumberth'])
        : null,
    thWidthTitleth: json.containsKey('thWidthTitleth')
        ? asT<String?>(json['thWidthTitleth'])
        : null,
    thWidthWorkOrderStatusth: json.containsKey('thWidthWorkOrderStatusth')
        ? asT<String?>(json['thWidthWorkOrderStatusth'])
        : null,
    thWidthCreationTimeth: json.containsKey('thWidthCreationTimeth')
        ? asT<String?>(json['thWidthCreationTimeth'])
        : null,
    thOperationth: json.containsKey('thOperationth')
        ? asT<String?>(json['thOperationth'])
        : null,
    divReturndiv: json.containsKey('divReturndiv')
        ? asT<String?>(json['divReturndiv'])
        : null,
    workOrderQuery: json.containsKey('workOrderQuery')
        ? asT<String?>(json['workOrderQuery'])
        : null,
    divClassti92ailsdivdiv: json.containsKey('divClassti92ailsdivdiv')
        ? asT<String?>(json['divClassti92ailsdivdiv'])
        : null,
    detailsOfCommunication: json.containsKey('detailsOfCommunication')
        ? asT<String?>(json['detailsOfCommunication'])
        : null,
    collectCommunicationDetails:
    json.containsKey('collectCommunicationDetails')
        ? asT<String?>(json['collectCommunicationDetails'])
        : null,
    robot: json.containsKey('robot') ? asT<String?>(json['robot']) : null,
  );

  String? thankYouFo106ualService;
  String? clickSubmitFormadiv;
  String? divClickaC16DataIframe;
  String? submitTheWorkOrderadiv;
  String? clickEnter;
  String? ticketQuery;
  String? switch1674461345561000;
  String? failedToDeliverBusinessRecords;
  String? buttonClas23tlasbutton;
  String? theButtonH17ainItAgain;
  String? pleaseGive13sThanWords;
  String? classcardV25eSelectdiv;
  String? spanClasst39lutionspan;
  String? spanClasst31Solvedspan;
  String? spanClasst27Enablespan;
  String? spanClasst29Closedspan;
  String? detailstd;
  String? divNumbernbsp;
  String? divClassti49ightdivdiv;
  String? thStylepaddingLeftpxNumberth;
  String? thWidthTitleth;
  String? thWidthWorkOrderStatusth;
  String? thWidthCreationTimeth;
  String? thOperationth;
  String? divReturndiv;
  String? workOrderQuery;
  String? divClassti92ailsdivdiv;
  String? detailsOfCommunication;
  String? collectCommunicationDetails;
  String? robot;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'thankYouFo106ualService': thankYouFo106ualService,
    'ClickSubmitFormadiv': clickSubmitFormadiv,
    'divClickaC16DataIframe': divClickaC16DataIframe,
    'SubmitTheWorkOrderadiv': submitTheWorkOrderadiv,
    'click_enter': clickEnter,
    'ticket_query': ticketQuery,
    'switch': switch1674461345561000,
    'failedToDeliverBusinessRecords': failedToDeliverBusinessRecords,
    'buttonClas23tlasbutton': buttonClas23tlasbutton,
    'theButtonH17ainItAgain': theButtonH17ainItAgain,
    'pleaseGive13sThanWords': pleaseGive13sThanWords,
    'classcardV25eSelectdiv': classcardV25eSelectdiv,
    'spanClasst39lutionspan': spanClasst39lutionspan,
    'spanClasst31Solvedspan': spanClasst31Solvedspan,
    'spanClasst27Enablespan': spanClasst27Enablespan,
    'spanClasst29Closedspan': spanClasst29Closedspan,
    'Detailstd': detailstd,
    'divNumbernbsp': divNumbernbsp,
    'divClassti49ightdivdiv': divClassti49ightdivdiv,
    'thStylepaddingLeftpxNumberth': thStylepaddingLeftpxNumberth,
    'thWidthTitleth': thWidthTitleth,
    'thWidthWorkOrderStatusth': thWidthWorkOrderStatusth,
    'thWidthCreationTimeth': thWidthCreationTimeth,
    'thOperationth': thOperationth,
    'divReturndiv': divReturndiv,
    'workOrderQuery': workOrderQuery,
    'divClassti92ailsdivdiv': divClassti92ailsdivdiv,
    'detailsOfCommunication': detailsOfCommunication,
    'collectCommunicationDetails': collectCommunicationDetails,
    'robot': robot,
  };
}

class Feedback4156 {
  Feedback4156({
    this.theLinkDoe28inistrator,
    this.theLastLevelMustBeSelected,
  });

  factory Feedback4156.fromJson(Map<String, dynamic> json) => Feedback4156(
    theLinkDoe28inistrator: json.containsKey('theLinkDoe28inistrator')
        ? asT<String?>(json['theLinkDoe28inistrator'])
        : null,
    theLastLevelMustBeSelected:
    json.containsKey('theLastLevelMustBeSelected')
        ? asT<String?>(json['theLastLevelMustBeSelected'])
        : null,
  );

  String? theLinkDoe28inistrator;
  String? theLastLevelMustBeSelected;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'theLinkDoe28inistrator': theLinkDoe28inistrator,
    'theLastLevelMustBeSelected': theLastLevelMustBeSelected,
  };
}

class Index {
  Index({
    this.udeskOfficialWebsite,
  });

  factory Index.fromJson(Map<String, dynamic> json) => Index(
    udeskOfficialWebsite: json.containsKey('udeskOfficialWebsite')
        ? asT<String?>(json['udeskOfficialWebsite'])
        : null,
  );

  String? udeskOfficialWebsite;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'udeskOfficialWebsite': udeskOfficialWebsite,
  };
}

class Lib {
  Lib({
    this.cascade,
    this.common,
    this.cti,
    this.iframeListener,
    this.imgViewer,
    this.msgFrequency,
    this.robot,
    this.sidebox,
    this.udeskCore,
    this.udeskUploader,
    this.ws,
  });

  factory Lib.fromJson(Map<String, dynamic> json) => Lib(
    cascade: json.containsKey('cascade')
        ? json['cascade'] == null
        ? null
        : Cascade.fromJson(asT<Map<String, dynamic>>(json['cascade'])!)
        : null,
    common: json.containsKey('common')
        ? json['common'] == null
        ? null
        : Common.fromJson(asT<Map<String, dynamic>>(json['common'])!)
        : null,
    cti: json.containsKey('cti')
        ? json['cti'] == null
        ? null
        : Cti.fromJson(asT<Map<String, dynamic>>(json['cti'])!)
        : null,
    iframeListener: json.containsKey('iframeListener')
        ? json['iframeListener'] == null
        ? null
        : IframeListener.fromJson(
        asT<Map<String, dynamic>>(json['iframeListener'])!)
        : null,
    imgViewer: json.containsKey('imgViewer')
        ? json['imgViewer'] == null
        ? null
        : ImgViewer.fromJson(
        asT<Map<String, dynamic>>(json['imgViewer'])!)
        : null,
    msgFrequency: json.containsKey('msgFrequency')
        ? json['msgFrequency'] == null
        ? null
        : MsgFrequency.fromJson(
        asT<Map<String, dynamic>>(json['msgFrequency'])!)
        : null,
    robot: json.containsKey('robot')
        ? json['robot'] == null
        ? null
        : RobotData.fromJson(asT<Map<String, dynamic>>(json['robot'])!)
        : null,
    sidebox: json.containsKey('sidebox')
        ? json['sidebox'] == null
        ? null
        : Sidebox.fromJson(asT<Map<String, dynamic>>(json['sidebox'])!)
        : null,
    udeskCore: json.containsKey('udeskCore')
        ? json['udesk.core'] == null
        ? null
        : UdeskCore.fromJson(
        asT<Map<String, dynamic>>(json['udesk.core'])!)
        : null,
    udeskUploader: json.containsKey('udeskUploader')
        ? json['udesk.uploader'] == null
        ? null
        : UdeskUploader.fromJson(
        asT<Map<String, dynamic>>(json['udesk.uploader'])!)
        : null,
    ws: json.containsKey('ws')
        ? json['ws'] == null
        ? null
        : Ws.fromJson(asT<Map<String, dynamic>>(json['ws'])!)
        : null,
  );

  Cascade? cascade;
  Common? common;
  Cti? cti;
  IframeListener? iframeListener;
  ImgViewer? imgViewer;
  MsgFrequency? msgFrequency;
  RobotData? robot;
  Sidebox? sidebox;
  UdeskCore? udeskCore;
  UdeskUploader? udeskUploader;
  Ws? ws;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'cascade': cascade,
    'common': common,
    'cti': cti,
    'iframeListener': iframeListener,
    'imgViewer': imgViewer,
    'msgFrequency': msgFrequency,
    'robot': robot,
    'sidebox': sidebox,
    'udesk.core': udeskCore,
    'udesk.uploader': udeskUploader,
    'ws': ws,
  };
}

class Cascade {
  Cascade({
    this.pleaseSelect,
  });

  factory Cascade.fromJson(Map<String, dynamic> json) => Cascade(
    pleaseSelect: json.containsKey('pleaseSelect')
        ? asT<String?>(json['pleaseSelect'])
        : null,
  );

  String? pleaseSelect;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'pleaseSelect': pleaseSelect,
  };
}

class Common {
  Common({
    this.theEncodin30nDiscarded,
    this.unexpectedError,
    this.spanStylec102tervalspan,
    this.flower,
    this.transferStopped,
    this.section,
    this.filesAreNo23otBeMerged,
    this.inconsiste22mplingRate,
    this.fileSizeExceedsTheLimit,
    this.atLeastOneWavNeedsToBeRecorded,
    this.excluded,
    this.nonWavFiles,
    this.merge,
    this.success,
    this.excluding,
    this.pleaseClearTheLogAndTryAgain,
    this.iAmLeaving,
    this.comeBack,
    this.errorInSendingToText,
    this.uploadFailed,
    this.theLinkDoe28inistrator,
    this.accept,
    this.cancel,
    this.pTheSystem29rmalPlease,
    this.refresha,
    this.baidu,
    this.google,
    this.goodSearch,
    this.bing,
    this.thereAreWays,
    this.taoBao,
    this.sogou,
    this.divineHorse,
    this.yahoo,
    this.todaysHeadline,
    this.directAccess,
    this.weChat,
    this.microblog,
    this.listPage,
    this.errorInGet52onSettings,
    this.newMessages,
    this.failedToSe22itiveWords,
    this.objectDoes20tyOrMethod,
    this.typeErrorC36pertyitems,
  });

  factory Common.fromJson(Map<String, dynamic> json) => Common(
    theEncodin30nDiscarded: json.containsKey('theEncodin30nDiscarded')
        ? asT<String?>(json['theEncodin30nDiscarded'])
        : null,
    unexpectedError: json.containsKey('unexpectedError')
        ? asT<String?>(json['unexpectedError'])
        : null,
    spanStylec102tervalspan: json.containsKey('spanStylec102tervalspan')
        ? asT<String?>(json['spanStylec102tervalspan'])
        : null,
    flower:
    json.containsKey('flower') ? asT<String?>(json['flower']) : null,
    transferStopped: json.containsKey('TransferStopped')
        ? asT<String?>(json['TransferStopped'])
        : null,
    section:
    json.containsKey('section') ? asT<String?>(json['section']) : null,
    filesAreNo23otBeMerged: json.containsKey('filesAreNo23otBeMerged')
        ? asT<String?>(json['filesAreNo23otBeMerged'])
        : null,
    inconsiste22mplingRate: json.containsKey('inconsiste22mplingRate')
        ? asT<String?>(json['inconsiste22mplingRate'])
        : null,
    fileSizeExceedsTheLimit: json.containsKey('fileSizeExceedsTheLimit')
        ? asT<String?>(json['fileSizeExceedsTheLimit'])
        : null,
    atLeastOneWavNeedsToBeRecorded:
    json.containsKey('atLeastOneWavNeedsToBeRecorded')
        ? asT<String?>(json['atLeastOneWavNeedsToBeRecorded'])
        : null,
    excluded: json.containsKey('Excluded')
        ? asT<String?>(json['Excluded'])
        : null,
    nonWavFiles: json.containsKey('nonWavFiles')
        ? asT<String?>(json['nonWavFiles'])
        : null,
    merge: json.containsKey('merge') ? asT<String?>(json['merge']) : null,
    success:
    json.containsKey('success') ? asT<String?>(json['success']) : null,
    excluding: json.containsKey('Excluding')
        ? asT<String?>(json['Excluding'])
        : null,
    pleaseClearTheLogAndTryAgain:
    json.containsKey('PleaseClearTheLogAndTryAgain')
        ? asT<String?>(json['PleaseClearTheLogAndTryAgain'])
        : null,
    iAmLeaving: json.containsKey('iAmLeaving')
        ? asT<String?>(json['iAmLeaving'])
        : null,
    comeBack: json.containsKey('comeBack')
        ? asT<String?>(json['comeBack'])
        : null,
    errorInSendingToText: json.containsKey('errorInSendingToText')
        ? asT<String?>(json['errorInSendingToText'])
        : null,
    uploadFailed: json.containsKey('uploadFailed')
        ? asT<String?>(json['uploadFailed'])
        : null,
    theLinkDoe28inistrator: json.containsKey('theLinkDoe28inistrator')
        ? asT<String?>(json['theLinkDoe28inistrator'])
        : null,
    accept:
    json.containsKey('accept') ? asT<String?>(json['accept']) : null,
    cancel:
    json.containsKey('cancel') ? asT<String?>(json['cancel']) : null,
    pTheSystem29rmalPlease: json.containsKey('pTheSystem29rmalPlease')
        ? asT<String?>(json['pTheSystem29rmalPlease'])
        : null,
    refresha: json.containsKey('Refresha')
        ? asT<String?>(json['Refresha'])
        : null,
    baidu: json.containsKey('baidu') ? asT<String?>(json['baidu']) : null,
    google:
    json.containsKey('google') ? asT<String?>(json['google']) : null,
    goodSearch: json.containsKey('goodSearch')
        ? asT<String?>(json['goodSearch'])
        : null,
    bing: json.containsKey('bing') ? asT<String?>(json['bing']) : null,
    thereAreWays: json.containsKey('thereAreWays')
        ? asT<String?>(json['thereAreWays'])
        : null,
    taoBao:
    json.containsKey('taoBao') ? asT<String?>(json['taoBao']) : null,
    sogou: json.containsKey('sogou') ? asT<String?>(json['sogou']) : null,
    divineHorse: json.containsKey('divineHorse')
        ? asT<String?>(json['divineHorse'])
        : null,
    yahoo: json.containsKey('yahoo') ? asT<String?>(json['yahoo']) : null,
    todaysHeadline: json.containsKey('todaysHeadline')
        ? asT<String?>(json['todaysHeadline'])
        : null,
    directAccess: json.containsKey('directAccess')
        ? asT<String?>(json['directAccess'])
        : null,
    weChat:
    json.containsKey('weChat') ? asT<String?>(json['weChat']) : null,
    microblog: json.containsKey('microblog')
        ? asT<String?>(json['microblog'])
        : null,
    listPage: json.containsKey('listPage')
        ? asT<String?>(json['listPage'])
        : null,
    errorInGet52onSettings: json.containsKey('errorInGet52onSettings')
        ? asT<String?>(json['errorInGet52onSettings'])
        : null,
    newMessages: json.containsKey('newMessages')
        ? asT<String?>(json['newMessages'])
        : null,
    failedToSe22itiveWords: json.containsKey('failedToSe22itiveWords')
        ? asT<String?>(json['failedToSe22itiveWords'])
        : null,
    objectDoes20tyOrMethod: json.containsKey('objectDoes20tyOrMethod')
        ? asT<String?>(json['objectDoes20tyOrMethod'])
        : null,
    typeErrorC36pertyitems: json.containsKey('typeErrorC36pertyitems')
        ? asT<String?>(json['typeErrorC36pertyitems'])
        : null,
  );

  String? theEncodin30nDiscarded;
  String? unexpectedError;
  String? spanStylec102tervalspan;
  String? flower;
  String? transferStopped;
  String? section;
  String? filesAreNo23otBeMerged;
  String? inconsiste22mplingRate;
  String? fileSizeExceedsTheLimit;
  String? atLeastOneWavNeedsToBeRecorded;
  String? excluded;
  String? nonWavFiles;
  String? merge;
  String? success;
  String? excluding;
  String? pleaseClearTheLogAndTryAgain;
  String? iAmLeaving;
  String? comeBack;
  String? errorInSendingToText;
  String? uploadFailed;
  String? theLinkDoe28inistrator;
  String? accept;
  String? cancel;
  String? pTheSystem29rmalPlease;
  String? refresha;
  String? baidu;
  String? google;
  String? goodSearch;
  String? bing;
  String? thereAreWays;
  String? taoBao;
  String? sogou;
  String? divineHorse;
  String? yahoo;
  String? todaysHeadline;
  String? directAccess;
  String? weChat;
  String? microblog;
  String? listPage;
  String? errorInGet52onSettings;
  String? newMessages;
  String? failedToSe22itiveWords;
  String? objectDoes20tyOrMethod;
  String? typeErrorC36pertyitems;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'theEncodin30nDiscarded': theEncodin30nDiscarded,
    'unexpectedError': unexpectedError,
    'spanStylec102tervalspan': spanStylec102tervalspan,
    'flower': flower,
    'TransferStopped': transferStopped,
    'section': section,
    'filesAreNo23otBeMerged': filesAreNo23otBeMerged,
    'inconsiste22mplingRate': inconsiste22mplingRate,
    'fileSizeExceedsTheLimit': fileSizeExceedsTheLimit,
    'atLeastOneWavNeedsToBeRecorded': atLeastOneWavNeedsToBeRecorded,
    'Excluded': excluded,
    'nonWavFiles': nonWavFiles,
    'merge': merge,
    'success': success,
    'Excluding': excluding,
    'PleaseClearTheLogAndTryAgain': pleaseClearTheLogAndTryAgain,
    'iAmLeaving': iAmLeaving,
    'comeBack': comeBack,
    'errorInSendingToText': errorInSendingToText,
    'uploadFailed': uploadFailed,
    'theLinkDoe28inistrator': theLinkDoe28inistrator,
    'accept': accept,
    'cancel': cancel,
    'pTheSystem29rmalPlease': pTheSystem29rmalPlease,
    'Refresha': refresha,
    'baidu': baidu,
    'google': google,
    'goodSearch': goodSearch,
    'bing': bing,
    'thereAreWays': thereAreWays,
    'taoBao': taoBao,
    'sogou': sogou,
    'divineHorse': divineHorse,
    'yahoo': yahoo,
    'todaysHeadline': todaysHeadline,
    'directAccess': directAccess,
    'weChat': weChat,
    'microblog': microblog,
    'listPage': listPage,
    'errorInGet52onSettings': errorInGet52onSettings,
    'newMessages': newMessages,
    'failedToSe22itiveWords': failedToSe22itiveWords,
    'objectDoes20tyOrMethod': objectDoes20tyOrMethod,
    'typeErrorC36pertyitems': typeErrorC36pertyitems,
  };
}

class Cti {
  Cti({
    this.rc,
    this.sign,
    this.vcall,
  });

  factory Cti.fromJson(Map<String, dynamic> json) => Cti(
    rc: json.containsKey('rc')
        ? json['rc'] == null
        ? null
        : Rc.fromJson(asT<Map<String, dynamic>>(json['rc'])!)
        : null,
    sign: json.containsKey('sign')
        ? json['sign'] == null
        ? null
        : Sign.fromJson(asT<Map<String, dynamic>>(json['sign'])!)
        : null,
    vcall: json.containsKey('vcall')
        ? json['vcall'] == null
        ? null
        : Vcall555.fromJson(asT<Map<String, dynamic>>(json['vcall'])!)
        : null,
  );

  Rc? rc;
  Sign? sign;
  Vcall555? vcall;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'rc': rc,
    'sign': sign,
    'vcall': vcall,
  };
}

class Rc {
  Rc({
    this.app,
    this.receivedPop,
  });

  factory Rc.fromJson(Map<String, dynamic> json) => Rc(
    app: json.containsKey('app')
        ? json['app'] == null
        ? null
        : App123.fromJson(asT<Map<String, dynamic>>(json['app'])!)
        : null,
    receivedPop: json.containsKey('receivedPop')
        ? json['receivedPop'] == null
        ? null
        : ReceivedPop.fromJson(
        asT<Map<String, dynamic>>(json['receivedPop'])!)
        : null,
  );

  App123? app;
  ReceivedPop? receivedPop;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'app': app,
    'receivedPop': receivedPop,
  };
}

class App123 {
  App123({
    this.initializationFailed,
  });

  factory App123.fromJson(Map<String, dynamic> json) => App123(
    initializationFailed: json.containsKey('initializationFailed')
        ? asT<String?>(json['initializationFailed'])
        : null,
  );

  String? initializationFailed;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'initializationFailed': initializationFailed,
  };
}

class ReceivedPop {
  ReceivedPop({
    this.spanClassr46mputerspan,
    this.aDataActre28ultRejecta,
    this.aDataActac28aryAccepta,
    this.divClassla124iatelyadiv,
    this.click,
    this.useNow,
  });

  factory ReceivedPop.fromJson(Map<String, dynamic> json) => ReceivedPop(
    spanClassr46mputerspan: json.containsKey('spanClassr46mputerspan')
        ? asT<String?>(json['spanClassr46mputerspan'])
        : null,
    aDataActre28ultRejecta: json.containsKey('aDataActre28ultRejecta')
        ? asT<String?>(json['aDataActre28ultRejecta'])
        : null,
    aDataActac28aryAccepta: json.containsKey('aDataActac28aryAccepta')
        ? asT<String?>(json['aDataActac28aryAccepta'])
        : null,
    divClassla124iatelyadiv: json.containsKey('divClassla124iatelyadiv')
        ? asT<String?>(json['divClassla124iatelyadiv'])
        : null,
    click: json.containsKey('click') ? asT<String?>(json['click']) : null,
    useNow:
    json.containsKey('use_now') ? asT<String?>(json['use_now']) : null,
  );

  String? spanClassr46mputerspan;
  String? aDataActre28ultRejecta;
  String? aDataActac28aryAccepta;
  String? divClassla124iatelyadiv;
  String? click;
  String? useNow;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'spanClassr46mputerspan': spanClassr46mputerspan,
    'aDataActre28ultRejecta': aDataActre28ultRejecta,
    'aDataActac28aryAccepta': aDataActac28aryAccepta,
    'divClassla124iatelyadiv': divClassla124iatelyadiv,
    'click': click,
    'use_now': useNow,
  };
}

class Sign {
  Sign({
    this.base,
  });

  factory Sign.fromJson(Map<String, dynamic> json) => Sign(
    base: json.containsKey('base')
        ? json['base'] == null
        ? null
        : Base.fromJson(asT<Map<String, dynamic>>(json['base'])!)
        : null,
  );

  Base? base;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'base': base,
  };
}

class Base {
  Base({
    this.loginFailed,
    this.failedToGetToken,
  });

  factory Base.fromJson(Map<String, dynamic> json) => Base(
    loginFailed: json.containsKey('loginFailed')
        ? asT<String?>(json['loginFailed'])
        : null,
    failedToGetToken: json.containsKey('failedToGetToken')
        ? asT<String?>(json['failedToGetToken'])
        : null,
  );

  String? loginFailed;
  String? failedToGetToken;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'loginFailed': loginFailed,
    'failedToGetToken': failedToGetToken,
  };
}

class Vcall555 {
  Vcall555({
    this.app,
    this.chatBox,
  });

  factory Vcall555.fromJson(Map<String, dynamic> json) => Vcall555(
    app: json.containsKey('app')
        ? json['app'] == null
        ? null
        : App.fromJson(asT<Map<String, dynamic>>(json['app'])!)
        : null,
    chatBox: json.containsKey('chatBox')
        ? json['chatBox'] == null
        ? null
        : ChatBox.fromJson(asT<Map<String, dynamic>>(json['chatBox'])!)
        : null,
  );

  App? app;
  ChatBox? chatBox;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'app': app,
    'chatBox': chatBox,
  };
}

class App {
  App({
    this.voice,
    this.video,
    this.launch,
    this.reject,
    this.missed,
    this.cancel,
    this.busy,
    this.end,
    this.getChannelTokenFailed,
    this.failedToJoinTheChannel,
    this.customerIs11ToTheVideo,
    this.theOtherPartyIsBusy,
    this.audiovideoChatIsNotSupported,
    this.pleaseEndTheCurrentVideoCall,
    this.initializationFailed,
  });

  factory App.fromJson(Map<String, dynamic> json) => App(
    voice: json.containsKey('voice') ? asT<String?>(json['voice']) : null,
    video: json.containsKey('video') ? asT<String?>(json['video']) : null,
    launch:
    json.containsKey('launch') ? asT<String?>(json['launch']) : null,
    reject:
    json.containsKey('reject') ? asT<String?>(json['reject']) : null,
    missed:
    json.containsKey('missed') ? asT<String?>(json['missed']) : null,
    cancel:
    json.containsKey('cancel') ? asT<String?>(json['cancel']) : null,
    busy: json.containsKey('busy') ? asT<String?>(json['busy']) : null,
    end: json.containsKey('end') ? asT<String?>(json['end']) : null,
    getChannelTokenFailed: json.containsKey('getChannelTokenFailed')
        ? asT<String?>(json['getChannelTokenFailed'])
        : null,
    failedToJoinTheChannel: json.containsKey('failedToJoinTheChannel')
        ? asT<String?>(json['failedToJoinTheChannel'])
        : null,
    customerIs11ToTheVideo: json.containsKey('customerIs11ToTheVideo')
        ? asT<String?>(json['customerIs11ToTheVideo'])
        : null,
    theOtherPartyIsBusy: json.containsKey('theOtherPartyIsBusy')
        ? asT<String?>(json['theOtherPartyIsBusy'])
        : null,
    audiovideoChatIsNotSupported:
    json.containsKey('audiovideoChatIsNotSupported')
        ? asT<String?>(json['audiovideoChatIsNotSupported'])
        : null,
    pleaseEndTheCurrentVideoCall:
    json.containsKey('pleaseEndTheCurrentVideoCall')
        ? asT<String?>(json['pleaseEndTheCurrentVideoCall'])
        : null,
    initializationFailed: json.containsKey('initializationFailed')
        ? asT<String?>(json['initializationFailed'])
        : null,
  );

  String? voice;
  String? video;
  String? launch;
  String? reject;
  String? missed;
  String? cancel;
  String? busy;
  String? end;
  String? getChannelTokenFailed;
  String? failedToJoinTheChannel;
  String? customerIs11ToTheVideo;
  String? theOtherPartyIsBusy;
  String? audiovideoChatIsNotSupported;
  String? pleaseEndTheCurrentVideoCall;
  String? initializationFailed;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'voice': voice,
    'video': video,
    'launch': launch,
    'reject': reject,
    'missed': missed,
    'cancel': cancel,
    'busy': busy,
    'end': end,
    'getChannelTokenFailed': getChannelTokenFailed,
    'failedToJoinTheChannel': failedToJoinTheChannel,
    'customerIs11ToTheVideo': customerIs11ToTheVideo,
    'theOtherPartyIsBusy': theOtherPartyIsBusy,
    'audiovideoChatIsNotSupported': audiovideoChatIsNotSupported,
    'pleaseEndTheCurrentVideoCall': pleaseEndTheCurrentVideoCall,
    'initializationFailed': initializationFailed,
  };
}

class ChatBox {
  ChatBox({
    this.aDataActsw31TitleMutea,
    this.aDataActsw34lespeakera,
    this.aDataActsw28itlevideoa,
  });

  factory ChatBox.fromJson(Map<String, dynamic> json) => ChatBox(
    aDataActsw31TitleMutea: json.containsKey('aDataActsw31TitleMutea')
        ? asT<String?>(json['aDataActsw31TitleMutea'])
        : null,
    aDataActsw34lespeakera: json.containsKey('aDataActsw34lespeakera')
        ? asT<String?>(json['aDataActsw34lespeakera'])
        : null,
    aDataActsw28itlevideoa: json.containsKey('aDataActsw28itlevideoa')
        ? asT<String?>(json['aDataActsw28itlevideoa'])
        : null,
  );

  String? aDataActsw31TitleMutea;
  String? aDataActsw34lespeakera;
  String? aDataActsw28itlevideoa;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'aDataActsw31TitleMutea': aDataActsw31TitleMutea,
    'aDataActsw34lespeakera': aDataActsw34lespeakera,
    'aDataActsw28itlevideoa': aDataActsw28itlevideoa,
  };
}

class IframeListener {
  IframeListener({
    this.sendingToo19AgainLater,
  });

  factory IframeListener.fromJson(Map<String, dynamic> json) => IframeListener(
    sendingToo19AgainLater: json.containsKey('sendingToo19AgainLater')
        ? asT<String?>(json['sendingToo19AgainLater'])
        : null,
  );

  String? sendingToo19AgainLater;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'sendingToo19AgainLater': sendingToo19AgainLater,
  };
}

class ImgViewer {
  ImgViewer({
    this.buttonClas39eEscbutton,
    this.aHrefjavas47eDownloada,
    this.buttonClas44reenbutton,
    this.buttonClas39noutbutton,
    this.buttonClas43iousbutton,
    this.buttonClas40Nextbutton,
    this.downloadpng,
    this.errorParsingFileName,
  });

  factory ImgViewer.fromJson(Map<String, dynamic> json) => ImgViewer(
    buttonClas39eEscbutton: json.containsKey('buttonClas39eEscbutton')
        ? asT<String?>(json['buttonClas39eEscbutton'])
        : null,
    aHrefjavas47eDownloada: json.containsKey('aHrefjavas47eDownloada')
        ? asT<String?>(json['aHrefjavas47eDownloada'])
        : null,
    buttonClas44reenbutton: json.containsKey('buttonClas44reenbutton')
        ? asT<String?>(json['buttonClas44reenbutton'])
        : null,
    buttonClas39noutbutton: json.containsKey('buttonClas39noutbutton')
        ? asT<String?>(json['buttonClas39noutbutton'])
        : null,
    buttonClas43iousbutton: json.containsKey('buttonClas43iousbutton')
        ? asT<String?>(json['buttonClas43iousbutton'])
        : null,
    buttonClas40Nextbutton: json.containsKey('buttonClas40Nextbutton')
        ? asT<String?>(json['buttonClas40Nextbutton'])
        : null,
    downloadpng: json.containsKey('downloadpng')
        ? asT<String?>(json['downloadpng'])
        : null,
    errorParsingFileName: json.containsKey('errorParsingFileName')
        ? asT<String?>(json['errorParsingFileName'])
        : null,
  );

  String? buttonClas39eEscbutton;
  String? aHrefjavas47eDownloada;
  String? buttonClas44reenbutton;
  String? buttonClas39noutbutton;
  String? buttonClas43iousbutton;
  String? buttonClas40Nextbutton;
  String? downloadpng;
  String? errorParsingFileName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'buttonClas39eEscbutton': buttonClas39eEscbutton,
    'aHrefjavas47eDownloada': aHrefjavas47eDownloada,
    'buttonClas44reenbutton': buttonClas44reenbutton,
    'buttonClas39noutbutton': buttonClas39noutbutton,
    'buttonClas43iousbutton': buttonClas43iousbutton,
    'buttonClas40Nextbutton': buttonClas40Nextbutton,
    'downloadpng': downloadpng,
    'errorParsingFileName': errorParsingFileName,
  };
}

class MsgFrequency {
  MsgFrequency({
    this.repeatMess12in3Seconds,
  });

  factory MsgFrequency.fromJson(Map<String, dynamic> json) => MsgFrequency(
    repeatMess12in3Seconds: json.containsKey('RepeatMess12in3Seconds')
        ? asT<String?>(json['RepeatMess12in3Seconds'])
        : null,
  );

  String? repeatMess12in3Seconds;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'RepeatMess12in3Seconds': repeatMess12in3Seconds,
  };
}

class RobotData {
  RobotData({
    this.structCardMsg,
  });

  factory RobotData.fromJson(Map<String, dynamic> json) => RobotData(
    structCardMsg: json.containsKey('structCardMsg')
        ? json['structCardMsg'] == null
        ? null
        : StructCardMsg.fromJson(
        asT<Map<String, dynamic>>(json['structCardMsg'])!)
        : null,
  );

  StructCardMsg? structCardMsg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'structCardMsg': structCardMsg,
  };
}

class StructCardMsg {
  StructCardMsg({
    this.liClasstex30eAGroupali,
    this.divChangeABatchdiv,
    this.divClassca44iewMorediv,
    this.reselectdiv,
  });

  factory StructCardMsg.fromJson(Map<String, dynamic> json) => StructCardMsg(
    liClasstex30eAGroupali: json.containsKey('liClasstex30eAGroupali')
        ? asT<String?>(json['liClasstex30eAGroupali'])
        : null,
    divChangeABatchdiv: json.containsKey('divChangeABatchdiv')
        ? asT<String?>(json['divChangeABatchdiv'])
        : null,
    divClassca44iewMorediv: json.containsKey('divClassca44iewMorediv')
        ? asT<String?>(json['divClassca44iewMorediv'])
        : null,
    reselectdiv: json.containsKey('Reselectdiv')
        ? asT<String?>(json['Reselectdiv'])
        : null,
  );

  String? liClasstex30eAGroupali;
  String? divChangeABatchdiv;
  String? divClassca44iewMorediv;
  String? reselectdiv;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'liClasstex30eAGroupali': liClasstex30eAGroupali,
    'divChangeABatchdiv': divChangeABatchdiv,
    'divClassca44iewMorediv': divClassca44iewMorediv,
    'Reselectdiv': reselectdiv,
  };
}

class Sidebox {
  Sidebox({
    this.dataReques28merService,
    this.commonProblem,
    this.hotspotIssues,
  });

  factory Sidebox.fromJson(Map<String, dynamic> json) => Sidebox(
    dataReques28merService: json.containsKey('dataReques28merService')
        ? asT<String?>(json['dataReques28merService'])
        : null,
    commonProblem: json.containsKey('commonProblem')
        ? asT<String?>(json['commonProblem'])
        : null,
    hotspotIssues: json.containsKey('hotspotIssues')
        ? asT<String?>(json['hotspotIssues'])
        : null,
  );

  String? dataReques28merService;
  String? commonProblem;
  String? hotspotIssues;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'dataReques28merService': dataReques28merService,
    'commonProblem': commonProblem,
    'hotspotIssues': hotspotIssues,
  };
}

class UdeskCore {
  UdeskCore({
    this.systemNotification,
  });

  factory UdeskCore.fromJson(Map<String, dynamic> json) => UdeskCore(
    systemNotification: json.containsKey('systemNotification')
        ? asT<String?>(json['systemNotification'])
        : null,
  );

  String? systemNotification;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'systemNotification': systemNotification,
  };
}

class UdeskUploader {
  UdeskUploader({
    this.failedToGetTokenWhenUploading,
    this.uploadFailedPleaseUploadAgain,
  });

  factory UdeskUploader.fromJson(Map<String, dynamic> json) => UdeskUploader(
    failedToGetTokenWhenUploading:
    json.containsKey('failedToGetTokenWhenUploading')
        ? asT<String?>(json['failedToGetTokenWhenUploading'])
        : null,
    uploadFailedPleaseUploadAgain:
    json.containsKey('uploadFailedPleaseUploadAgain')
        ? asT<String?>(json['uploadFailedPleaseUploadAgain'])
        : null,
  );

  String? failedToGetTokenWhenUploading;
  String? uploadFailedPleaseUploadAgain;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'failedToGetTokenWhenUploading': failedToGetTokenWhenUploading,
    'uploadFailedPleaseUploadAgain': uploadFailedPleaseUploadAgain,
  };
}

class Ws {
  Ws({
    this.core,
  });

  factory Ws.fromJson(Map<String, dynamic> json) => Ws(
    core: json.containsKey('core')
        ? json['core'] == null
        ? null
        : Core.fromJson(asT<Map<String, dynamic>>(json['core'])!)
        : null,
  );

  Core? core;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'core': core,
  };
}

class Core {
  Core({
    this.receiptTimeout,
    this.overtime,
  });

  factory Core.fromJson(Map<String, dynamic> json) => Core(
    receiptTimeout: json.containsKey('receiptTimeout')
        ? asT<String?>(json['receiptTimeout'])
        : null,
    overtime: json.containsKey('overtime')
        ? asT<String?>(json['overtime'])
        : null,
  );

  String? receiptTimeout;
  String? overtime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'receiptTimeout': receiptTimeout,
    'overtime': overtime,
  };
}

class Merchant {
  Merchant({
    this.richText,
    this.picture,
    this.video,
    this.thisTypeOf22emporarily,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    richText: json.containsKey('RichText')
        ? asT<String?>(json['RichText'])
        : null,
    picture:
    json.containsKey('Picture') ? asT<String?>(json['Picture']) : null,
    video: json.containsKey('Video') ? asT<String?>(json['Video']) : null,
    thisTypeOf22emporarily: json.containsKey('ThisTypeOf22emporarily')
        ? asT<String?>(json['ThisTypeOf22emporarily'])
        : null,
  );

  String? richText;
  String? picture;
  String? video;
  String? thisTypeOf22emporarily;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'RichText': richText,
    'Picture': picture,
    'Video': video,
    'ThisTypeOf22emporarily': thisTypeOf22emporarily,
  };
}

class TicketData {
  TicketData({
    this.submissionFailedPleaseTryAgain,
    this.failedToOb12seTryAgain,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
    submissionFailedPleaseTryAgain:
    json.containsKey('submissionFailedPleaseTryAgain')
        ? asT<String?>(json['submissionFailedPleaseTryAgain'])
        : null,
    failedToOb12seTryAgain: json.containsKey('failedToOb12seTryAgain')
        ? asT<String?>(json['failedToOb12seTryAgain'])
        : null,
  );

  String? submissionFailedPleaseTryAgain;
  String? failedToOb12seTryAgain;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'submissionFailedPleaseTryAgain': submissionFailedPleaseTryAgain,
    'failedToOb12seTryAgain': failedToOb12seTryAgain,
  };
}

class UdeskFeedback {
  UdeskFeedback({
    this.support,
    this.pleaseDragTheScreenshot,
  });

  factory UdeskFeedback.fromJson(Map<String, dynamic> json) => UdeskFeedback(
    support:
    json.containsKey('support') ? asT<String?>(json['support']) : null,
    pleaseDragTheScreenshot: json.containsKey('pleaseDragTheScreenshot')
        ? asT<String?>(json['pleaseDragTheScreenshot'])
        : null,
  );

  String? support;
  String? pleaseDragTheScreenshot;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'support': support,
    'pleaseDragTheScreenshot': pleaseDragTheScreenshot,
  };
}

class Ui {
  Ui({
    this.core,
  });

  factory Ui.fromJson(Map<String, dynamic> json) => Ui(
    core: json.containsKey('core')
        ? json['core'] == null
        ? null
        : CoreData.fromJson(asT<Map<String, dynamic>>(json['core'])!)
        : null,
  );

  CoreData? core;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'core': core,
  };
}

class CoreData {
  CoreData({
    this.determine,
    this.cancel,
    this.holdToTalk,
  });

  factory CoreData.fromJson(Map<String, dynamic> json) => CoreData(
    determine: json.containsKey('determine')
        ? asT<String?>(json['determine'])
        : null,
    cancel:
    json.containsKey('cancel') ? asT<String?>(json['cancel']) : null,
    holdToTalk: json.containsKey('holdToTalk')
        ? asT<String?>(json['holdToTalk'])
        : null,
  );

  String? determine;
  String? cancel;
  String? holdToTalk;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'determine': determine,
    'cancel': cancel,
    'holdToTalk': holdToTalk,
  };
}

const goMyPbi = () => {
	sessionStorage.removeItem('al-sort');
	sessionStorage.removeItem('sl-sort');
	location.href = '/recruit/';
}

const goLogin = () => {
	location.href = '/recruit/page/view/login.jsp?np=login';
}

const goJoin = () => {
	location.href = '/recruit/page/view/join.jsp?np=join';
}

const goFindPW = () => {
	location.href = '/recruit/page/view/find-pw.jsp?np=fpw';
}

const goReg = () => {
	location.href = '/recruit/page/view/reg.jsp?np=reg';
}

const goMyPage = () => {
	location.href = '/recruit/page/view/mypage.jsp?np=mp';
}

const goPbiUpdate = (id) => {
	location.href = '/recruit/page/view/mypbi-update.jsp?np=regu&id=' + id;
}

const goApplicantList = (id) => {
	const scroll = $(window).scrollTop();
	sessionStorage.setItem('mypbi-scroll', scroll);
	sessionStorage.removeItem('al-sort');
	location.href = '/recruit/page/view/applicant-list.jsp?np=al&id=' + id;
}

const goApplicantDetail = (id) => {
	location.href = '/recruit/page/view/applicant-detail.jsp?np=ad&id=' + id;
}

const goScoreList = (id) => {
	const scroll = $(window).scrollTop();
	sessionStorage.setItem('mypbi-scroll', scroll);
	sessionStorage.removeItem('team-score');
	sessionStorage.removeItem('sl-sort');
	location.href = '/recruit/page/view/score-list.jsp?np=sl&id=' + id;
}

const goScoreDetail = (id) => {
	location.href = '/recruit/page/view/applicant-detail.jsp?np=sd&id=' + id;
}

const goLocationTerms = () => {
	window.open('/recruit/page/terms/location_based_service.jsp');
}

const goPersonalInfoTerms = () => {
	window.open('/recruit/page/terms/personal_info.jsp');
}

const goServiceTerms = () => {
	window.open('/recruit/page/terms/terms_of_service.jsp');
}

const goRecruitInfoPopup = () => {
	window.open('/recruit/page/popup/recruit-info.jsp');
}
<%@ page language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="/tags/struts-html" %>
<%@ taglib prefix="bean" uri="/tags/struts-bean" %>
<%@ taglib prefix="tc-webtag" uri="/tags/tc-webtags" %>
<c:if test="${isAllowedToViewResources}">
	<table class="scorecard" style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td class="title" colspan='${(isAllowedToViewAllPayment) ? "4" : "2"}'><bean:message key="viewProjectDetails.box.Resources" /></td>
		</tr>
		<tr>
			<td class="header"><b><bean:message key="viewProjectDetails.Resource.Role" /></b></td>
			<td class="header"><b><bean:message key="viewProjectDetails.Resource.Name" /></b></td>
			<c:if test="${isAllowedToViewAllPayment}">
				<td class="header" nowrap="nowrap"><b><bean:message key="viewProjectDetails.Resource.Payment" /></b></td>
				<td class="header" nowrap="nowrap"><b><bean:message key="viewProjectDetails.Resource.Paid_qm" /></b></td>
			</c:if>
		</tr>
		<c:forEach items="${resources}" var="resource" varStatus="idxrResource">
			<tr class='${(idxrResource.index % 2 == 0) ? "light" : "dark"}'>
				<td class="value" nowrap="nowrap"><bean:message key='ResourceRole.${fn:replace(resource.resourceRole.name, " ", "")}.bold' /></td>
				<td class="value" nowrap="nowrap">
					<html:link href="mailto:${users[idxrResource.index].email}" title="Send Email"><html:img srcKey="viewProjectDetails.Resource.Email.img" border="0" /></html:link>
					<tc-webtag:handle coderId="${users[idxrResource.index].id}" context="component" />
				</td>
				<c:if test="${isAllowedToViewAllPayment}">
					<c:choose>
						<c:when test='${!(empty resource.allProperties["Payment"])}'>
							<td class="value" nowrap="nowrap">${"$"}${resource.allProperties["Payment"]}</td>
						</c:when>
						<c:otherwise>
							<td class="value" nowrap="nowrap"><bean:message key="NotAvailable" /></td>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test='${!(empty resource.allProperties["Payment"]) && !(empty resource.allProperties["Payment Status"])}'>
							<td class="value" nowrap="nowrap"><bean:message key='viewProjectDetails.Resource.Paid.${(resource.allProperties["Payment Status"] == "Yes") ? "yes" : "no"}' /></td>
						</c:when>
						<c:otherwise>
							<td class="value" nowrap="nowrap"><bean:message key="NotAvailable" /></td>
						</c:otherwise>
					</c:choose>
				</c:if>
			</tr>
		</c:forEach>
		<tr>
			<td class="lastRowTD" colspan='${(isAllowedToViewAllPayment) ? "4" : "2"}'><!-- @ --></td>
		</tr>
	</table><br />
</c:if>
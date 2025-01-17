<f:view>
<div class="portletBody">
<h:form id="rosterForm">

    <sakai:flowState bean="#{rosterBean}"/>

    <t:aliasBean alias="#{viewName}" value="roster">
        <%@ include file="/inc/navMenu.jspf"%>
    </t:aliasBean>

    <div class="page-header">
        <h1><h:outputText value="#{msgs.student_member}"/></h1>
    </div>

	<div class="instructions">	
		<h:outputText value="#{msgs.roster_instructions}"
			rendered="#{ ! rosterBean.externallyManaged}"/>
	</div>

    <%@ include file="/inc/globalMessages.jspf"%>

	<t:div>
		<h:outputText value="#{msgs.roster_view_students}"/>
        <h:selectOneMenu value="#{rosterBean.filter}" onchange="this.form.submit()" rendered="#{rosterBean.sectionAssignable}">
            <f:selectItems value="#{rosterBean.filterItems}"/>
        </h:selectOneMenu>
        <h:outputText value="#{msgs.filter_all_sections}" rendered="#{ ! rosterBean.sectionAssignable}"/>
	</t:div>
	
    <h:panelGrid styleClass="sectionContainerNav" columns="1" columnClasses="sectionLeftNav,sectionRightNav">
        <t:div>
            <h:inputText id="search" onkeydown="submitSearchText(event)" value="#{rosterBean.searchText}"
                onfocus="clearIfDefaultString(this, '#{msgs.roster_search_text}')"/>
            <h:commandButton value="#{msgs.roster_search_button}" actionListener="#{rosterBean.search}"/>
            <h:commandButton value="#{msgs.roster_clear_button}" actionListener="#{rosterBean.clearSearch}"/>
        </t:div>
        
        <t:div>
            <sakai:pager
                id="pager"
                totalItems="#{rosterBean.enrollmentsSize}"
                firstItem="#{rosterBean.firstRow}"
                pageSize="#{preferencesBean.rosterMaxDisplayedRows}"
                textStatus="#{msgs.roster_pager_status}" />
        </t:div>
    </h:panelGrid>
    
    <h:panelGroup rendered="#{rosterBean.enrollmentsSize <= 0}" >
        <h:outputText styleClass="sak-banner-warn" value="#{msgs.students_not_found}"  />
    </h:panelGroup>

    <t:dataTable cellpadding="0" cellspacing="0"
        id="sectionsTable"
        value="#{rosterBean.enrollments}"
        var="enrollment"
        binding="#{rosterBean.rosterDataTable}"
        sortColumn="#{preferencesBean.rosterSortColumn}"
        sortAscending="#{preferencesBean.rosterSortAscending}"
        rendered="#{rosterBean.enrollmentsSize > 0}"
        styleClass="listHier rosterTable">
        <h:column>
            <f:facet name="header">
                <t:commandSortHeader columnName="studentName" immediate="true" arrow="true">
                    <h:outputText value="#{msgs.roster_table_header_name}" />
                </t:commandSortHeader>
            </f:facet>
            <h:commandLink
                action="editStudentSections"
                value="#{enrollment.user.sortName}"
                rendered="#{navMenuBean.sectionEnrollmentMangementEnabled}">
                    <f:param name="studentUid" value="#{enrollment.user.userUid}"/>
            </h:commandLink>
            <h:outputText
                value="#{enrollment.user.sortName}"
                rendered="#{!navMenuBean.sectionEnrollmentMangementEnabled}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <t:commandSortHeader columnName="displayId" immediate="true" arrow="true">
                    <h:outputText value="#{msgs.roster_table_header_id}" />
                </t:commandSortHeader>
            </f:facet>
            <h:outputText value="#{enrollment.user.displayId}"/>
        </h:column>
        
        <%/* A dynamic number of section columns will be appended here by the backing bean */%>
    
    </t:dataTable>
</h:form>
</div>
</f:view>

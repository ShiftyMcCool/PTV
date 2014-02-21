<cfcomponent name="PageTemplateService" output="false" extends="apphome.model.BaseService">

	<cffunction name="init" access="public" output="false" returntype="apphome.model.PageTemplateService">
		<cfargument name="PageTemplateDAO" type="apphome.model.PageTemplateDAO" required="true" />
		<cfargument name="PageTemplateGateway" type="apphome.model.PageTemplateGateway" required="true" />

		<cfset variables.PageTemplateDAO = arguments.PageTemplateDAO />
		<cfset variables.PageTemplateGateway = arguments.PageTemplateGateway />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createPageTemplate" access="public" output="false" returntype="apphome.model.PageTemplate">
		<cfargument name="ID" type="numeric" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Cost" type="numeric" required="false" />
		<cfargument name="SmallPic" type="string" required="false" />
		<cfargument name="LargePic" type="string" required="false" />
		
		<cfset var PageTemplate = createObject("component","apphome.model.PageTemplate").init(argumentCollection=arguments) />

		<cfreturn PageTemplate />
	</cffunction>

	<cffunction name="getPageTemplate" access="public" output="false" returntype="apphome.model.PageTemplate">
		<cfargument name="ID" type="numeric" required="false" />

		<cfset var PageTemplate = createPageTemplate(argumentCollection=arguments) />
		<cfset variables.PageTemplateDAO.read(PageTemplate) />

		<cfreturn PageTemplate />
	</cffunction>

	<cffunction name="getPortfolio" access="public" output="false" returntype="array">		
		<cfreturn variables.PageTemplateGateway.getPortfolio() />
	</cffunction>

	<cffunction name="savePageTemplate" access="public" output="false" returntype="boolean">
		<cfargument name="PageTemplate" type="apphome.model.PageTemplate" required="true" />

		<cfreturn variables.PageTemplateDAO.save(PageTemplate) />
	</cffunction>

	<cffunction name="deletePageTemplate" access="public" output="false" returntype="boolean">
		<cfargument name="PageTemplate" type="apphome.model.PageTemplate" required="true" />

		<cfreturn variables.PageTemplateDAO.delete(ARGUMENTS.PageTemplate) />
	</cffunction>
</cfcomponent>
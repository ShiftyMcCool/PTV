<cfcomponent displayname="PageTemplateDAO">

	<cffunction name="init" access="public" output="false" returntype="apphome.model.PageTemplateDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="PageTemplate" type="apphome.model.PageTemplate" required="true" />
		<cfset var LOCAL = {} /><cfprocessingdirective suppressWhitespace="true">

		<cftry>
			<cffile action="read" file="#expandpath('\xml\PageTemplatePortfolio.xml')#" variable="LOCAL.PageTemplates" />

			<cfoutput>
<cfsavecontent variable="LOCAL.newRecord">
	<pagetemplate>
		<id>#ARGUMENTS.PageTemplate.getID()#</id>
		<title>#ARGUMENTS.PageTemplate.getTitle()#</title>
		<description>#ARGUMENTS.PageTemplate.getDescription()#</description>
		<cost>#ARGUMENTS.PageTemplate.getCost()#</cost>
		<smallpic>#ARGUMENTS.PageTemplate.getSmallPic()#</smallpic>
		<largepic>#ARGUMENTS.PageTemplate.getLargePic()#</largepic>
	</pagetemplate>
</cfsavecontent>
			</cfoutput>
			
			<cfset LOCAL.EndRoot = find("</portfolio>", LOCAL.PageTemplates) - 1 />
			<cfset LOCAL.PageTemplates = insert(LOCAL.newRecord, LOCAL.PageTemplates, LOCAL.EndRoot) />

			<cffile action="write" file="#expandpath('\xml\PageTemplatePortfolio.xml')#" output="#LOCAL.PageTemplates#" nameconflict="overwrite" />

			<cfcatch type="any">
				<cfreturn false />
			</cfcatch>
		</cftry>

		</cfprocessingdirective><cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="PageTemplate" type="apphome.model.PageTemplate" required="true" />

		<cfset var LOCAL = {} />
		<cfset LOCAL.retVal = {} />
		<cfset LOCAL.pageTemplateData = "" />

		<cffile action="read" file="#expandpath('\xml\PageTemplatePortfolio.xml')#" variable="LOCAL.ptxml" />

		<cfset LOCAL.pageTemplates = XmlParse(LOCAL.ptxml) />

		<cfset LOCAL.PageTemplateIDs = xmlSearch(LOCAL.pageTemplates, "/portfolio/pagetemplate/id") />

		<cfloop array="#LOCAL.PageTemplateIDs#" index="LOCAL.x">
			<cfif LOCAL.x[1].xmltext EQ ARGUMENTS.PageTemplate.getID()>
				<cfset LOCAL.pageTemplateData = LOCAL.x.xmlparent />
			</cfif>
		</cfloop>

		<cfif LOCAL.PageTemplateData NEQ "">	
			<cfset LOCAL.retVal.ID = LOCAL.pageTemplateData.ID.xmltext />
			<cfset LOCAL.retVal.Title = LOCAL.pageTemplateData.title.xmltext />
			<cfset LOCAL.retVal.Description = LOCAL.pageTemplateData.description.xmltext />
			<cfset LOCAL.retVal.Cost = LOCAL.pageTemplateData.cost.xmltext />
			<cfset LOCAL.retVal.SmallPic = LOCAL.pageTemplateData.smallpic.xmltext />
			<cfset LOCAL.retVal.LargePic = LOCAL.pageTemplateData.largepic.xmltext />
		<cfelse>
			<cfset LOCAL.retVal.ID = "0" />
			<cfset LOCAL.retVal.Title = "" />
			<cfset LOCAL.retVal.Description = "" />
			<cfset LOCAL.retVal.Cost = "0" />
			<cfset LOCAL.retVal.SmallPic = "" />
			<cfset LOCAL.retVal.LargePic = "" />
		</cfif>

		<cfset ARGUMENTS.PageTemplate.init(argumentCollection = LOCAL.retVal) />
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="PageTemplate" type="apphome.model.PageTemplate" required="true" />

		<cfset var LOCAL = {} />

		<cftry>
			<cffile action="read" file="#expandpath('\xml\PageTemplatePortfolio.xml')#" variable="LOCAL.ptxml" />

			<cfset LOCAL.pageTemplates = XmlParse(LOCAL.ptxml) />

			<cfset LOCAL.PageTemplateIDs = xmlSearch(LOCAL.pageTemplates, "/portfolio/pagetemplate/id") />

			<cfloop array="#LOCAL.PageTemplateIDs#" index="LOCAL.x">
				<cfif LOCAL.x[1].xmltext EQ ARGUMENTS.PageTemplate.getID()>
					<cfset LOCAL.pageTemplateData = LOCAL.x.xmlparent />
				</cfif>
			</cfloop>

			<cfset LOCAL.pageTemplateData.ID.xmltext = ARGUMENTS.PageTemplate.getID() />
			<cfset LOCAL.pageTemplateData.title.xmltext = ARGUMENTS.PageTemplate.getTitle() />
			<cfset LOCAL.pageTemplateData.description.xmltext = ARGUMENTS.PageTemplate.getDescription() />
			<cfset LOCAL.pageTemplateData.cost.xmltext = ARGUMENTS.PageTemplate.getCost() />
			<cfset LOCAL.pageTemplateData.smallpic.xmltext = ARGUMENTS.PageTemplate.getSmallPic() />
			<cfset LOCAL.pageTemplateData.largepic.xmltext = ARGUMENTS.PageTemplate.getLargePic() />

			<cffile action="write" file="#expandpath('\xml\PageTemplatePortfolio.xml')#" output="#ToString(LOCAL.pageTemplates)#" nameconflict="overwrite" />

			<cfcatch type="any">
				<cfreturn false />
			</cfcatch>
		</cftry>

		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="PageTemplate" type="apphome.model.PageTemplate" required="true" />
		<cfset var LOCAL = {} />
		<cfset LOCAL.RetVal = {} />
		
		<cftry>
			<cffile action="read" file="#expandpath('\xml\PageTemplatePortfolio.xml')#" variable="LOCAL.XMLText" />

			<cfset LOCAL.pageTemplates = XmlParse(LOCAL.XMLText) />	

			<cfset LOCAL.PageTemplateIDs = xmlSearch(LOCAL.pageTemplates, "/portfolio/pagetemplate/id") />

			<cfloop array="#LOCAL.PageTemplateIDs#" index="LOCAL.x">
				<cfif LOCAL.x[1].xmltext EQ ARGUMENTS.PageTemplate.getID()>
					<cfset LOCAL.pageTemplateData = LOCAL.x.xmlparent />
				</cfif>
			</cfloop>

			<cfset XmlDeleteNodes(LOCAL.pageTemplates, LOCAL.PageTemplateData) />

			<cffile action="write" file="#expandpath('\xml\PageTemplatePortfolio.xml')#" output="#ToString(LOCAL.pageTemplates)#" nameconflict="overwrite" />

			<cfcatch type="any">
				<cfreturn false />
			</cfcatch>
		</cftry>

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="PageTemplate" type="apphome.model.PageTemplate" required="true" />

		<cfset var LOCAL = {} />
		<cfset LOCAL.IDTag = "<id>" & ARGUMENTS.PageTemplate.getID() & "</id>" />

		<cffile action="read" file="#expandpath('\xml\PageTemplatePortfolio.xml')#" variable="LOCAL.XMLText" />

		<cfset LOCAL.IDExists = find(LOCAL.IDTag, LOCAL.XMLText) />

		<cfif LOCAL.IDExists>
			<cfreturn LOCAL.IDExists />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="PageTemplate" type="apphome.model.PageTemplate" required="true" />
		
		<cfset LOCAL = {} />
		<cfset LOCAL.success = false />

		<cfif exists(arguments.PageTemplate)>
			<cfset LOCAL.success = update(arguments.PageTemplate) />
		<cfelse>
			<cfset LOCAL.success = create(arguments.PageTemplate) />
		</cfif>
		
		<cfreturn LOCAL.success />
	</cffunction>

	<cffunction name="XmlDeleteNodes" access="private" output="false" returntype="void" hint="Courtesy of Ben Nadel">
		<cfargument name="XmlDocument" type="any" required="true" />
		<cfargument name="Nodes" type="any" required="false" />
 
		<cfset var LOCAL = {} />
		
		<cfif NOT IsArray( ARGUMENTS.Nodes )>
 			<cfset LOCAL.Node = ARGUMENTS.Nodes />
			<cfset ARGUMENTS.Nodes = [ LOCAL.Node ] />
		</cfif>

		<cfloop index="LOCAL.NodeIndex" from="#ArrayLen( ARGUMENTS.Nodes )#" to="1" step="-1">
			<cfset LOCAL.Node = ARGUMENTS.Nodes[ LOCAL.NodeIndex ] />

			<cfif StructKeyExists( LOCAL.Node, "XmlChildren" )>
				<cfset LOCAL.Node.XmlAttributes[ "delete-me-flag" ] = "true" />
 			<cfelse>
				<cfset ArrayDeleteAt(ARGUMENTS.Nodes, LOCAL.NodeIndex) />
			</cfif>
 		</cfloop>
		
		<cfloop index="LOCAL.Node" array="#ARGUMENTS.Nodes#">
			<cfset LOCAL.ParentNodes = XmlSearch( LOCAL.Node, "../" ) />
			
			<cfif (ArrayLen( LOCAL.ParentNodes ) AND StructKeyExists( LOCAL.ParentNodes[ 1 ], "XmlChildren" ))>
 				<cfset LOCAL.ParentNode = LOCAL.ParentNodes[ 1 ] />
		 		
		 		<cfloop index="LOCAL.NodeIndex" from="#ArrayLen( LOCAL.ParentNode.XmlChildren )#" to="1" step="-1">
					<cfset LOCAL.Node = LOCAL.ParentNode.XmlChildren[ LOCAL.NodeIndex ] />
					
					<cfif StructKeyExists( LOCAL.Node.XmlAttributes, "delete-me-flag" )>
 						<cfset ArrayDeleteAt(LOCAL.ParentNode.XmlChildren, LOCAL.NodeIndex) />
 						<cfset StructDelete(LOCAL.Node.XmlAttributes, "delete-me-flag") />
					</cfif>
				</cfloop>
			</cfif>
		</cfloop>

		<cfreturn />
	</cffunction>

</cfcomponent>

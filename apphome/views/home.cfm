<!doctype html>
<html class="no-js" lang="en"> 
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <title>Code Development Test</title>

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/assets/css/style.css?v=2">

</head>

<body>

<cfif event.getArg("SaveResult") NEQ "">
	<cfif event.getArg("SaveResult")>
		<cfset SaveToast = "<b>Success!</b>">
	<cfelseif !event.getArg("SaveResult")>
		<cfset SaveToast = "<b>Error</b>" />
	</cfif>
<cfelse>
	<cfset SaveToast = "" />
</cfif>

  <div id="container">
	<header>
		Code Development Project
	</header>
	<div id="main" role="main">
		<div id="large">
			<div class="group">
				<cfoutput>
				<img id="largeimage" src="" alt="Large Image" width="430" height="360" />
				</cfoutput>
				<div class="details">
					<form name="editPageTemplate" id="editPageTemplate" action="/apphome/index.cfm?event=save" method="post">
						<cfoutput>
						<p><strong>Title</strong> <input type="text" name="Title" class="form-field" id="title" value="" disabled="true" /></p>
						<p><strong>Description</strong> <textarea type="text" name="Description" class="form-field" id="description" cols="29" rows="6" disabled="true"></textarea></p>
						<p><strong>Cost</strong> $<input type="text" name="Cost" class="form-field" id="cost" value="" disabled="true" /></p>
						<p><strong>ID ##</strong> <input type="text" name="PTID" class="form-field" id="pid" value="" disabled="true" /></p>
						<p><strong>Thumbnail File</strong> <input type="text" name="SmallPic" class="form-field" id="smallpic" value="" disabled="true" /></p>
						<p><strong>Large Image File</strong> <input type="text" name="LargePic" class="form-field" id="largepic" value="" disabled="true" size="18" /></p>
						</cfoutput>
						<p>
							<input type="button" class="form-button" id="addTemplate" value="Add" />
							<input type="button" class="form-button" id="editTemplate" value="Edit" />
							<input type="submit" class="form-button" id="deleteTemplate" value="Delete" />
							<input type="button" class="form-button hidden" id="cancelEdit" value="Cancel" />
							<input type="submit" class="form-button hidden" id="submitForm" value="Submit" />
							<span id="saveResult"><cfoutput>#SaveToast#</cfoutput></span>
						</p>
					</form>
				</div>
			</div>
		</div></div>
		<div id="carousel">
			<div>
			<span class="als-prev"><img src="/assets/images/previous.png" alt="prev" title="previous" /></span>
			<div class="als-viewport">
				<ul class="als-wrapper">
					<cfoutput>
					<cfloop array="#event.getArg("Portfolio")#" index="x">
						<li class="als-item">
							<a href="javascript:void(0)" class="als-link" pid="#x.id#" title="#x.title#" description="#x.description#" cost="#x.cost#" smallpic="#x.smallPic#" largepic="#x.largepic#">
								<img src="/assets/images/thumbnails/#x.smallPic#" class="thumbnail" width="145" height="121" alt="#x.id#" title="#x.title#" />
								<span class="thumbLink">#x.id#</span>
							</a>
						</li>
					</cfloop>
					</cfoutput>
				</ul>
			</div>
			<span class="als-next"><img src="/assets/images/next.png" alt="next" title="next" /></span>
			</div>
		</div>
	
	<footer>
		<a href="/instructions.pdf">Download PDF Instructions</a>
	</footer>
  </div> <!-- eo #container -->

</body>

<script src="/assets/js/jquery.min.js?20140203"></script>
<script src="/assets/js/jquery.als.js?20140203"></script>
<script src="/assets/js/page-template-viewer.js?20140203"></script>

</html>
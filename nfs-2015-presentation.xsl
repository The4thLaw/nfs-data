<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" />

	<xsl:template match="/">
		<html>
		<head>
			<title>NFS 2015 cars data sheet</title>
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"></link>
			<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css"></link>
			<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.0/css/buttons.bootstrap4.min.css"></link>
			<link rel="stylesheet" href="https://cdn.datatables.net/fixedcolumns/3.2.4/css/fixedColumns.bootstrap4.min.css"></link>
			<link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.1.3/css/fixedHeader.bootstrap4.min.css"></link>
			<script src="https://code.jquery.com/jquery-3.2.1.min.js" crossorigin="anonymous"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.13.0/umd/popper.min.js" crossorigin="anonymous"></script>
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" crossorigin="anonymous"></script>
			<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
			<script src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
			<script src="https://cdn.datatables.net/buttons/1.5.0/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
			<script src="https://cdn.datatables.net/buttons/1.5.0/js/buttons.bootstrap4.min.js" crossorigin="anonymous"></script>
			<script src="https://cdn.datatables.net/buttons/1.5.0/js/buttons.colVis.min.js" crossorigin="anonymous"></script>
			<script src="https://cdn.datatables.net/fixedcolumns/3.2.4/js/dataTables.fixedColumns.min.js" crossorigin="anonymous"></script>
			<script src="https://cdn.datatables.net/fixedheader/3.1.3/js/dataTables.fixedHeader.min.js" crossorigin="anonymous"></script>
			
			<style type="text/css">
			table.dataTable thead tr:first-child th {
				/* Fix double borders */
				border-bottom: 0;
				border-top: 0:
			}
			
			th, td { white-space: nowrap; }
			
			.DTFC_LeftBodyLiner {
				/* Override style set on element */
				overflow-y: hidden !important;
				/* Don't let content show behind when scrolling */
				background: white;
			}
			
			.outofdate::after {
				content: '⚠';
				cursor: help;
			}
			</style>
		</head>
		<body>
			<table id="car-data" class="table table-striped table-hover table-bordered">
				<thead class="thead-default">
					<tr>
						<th colspan="5">General information</th>
						<th colspan="4">Stock stats</th>
						<th colspan="4">Max stats</th>
						<th colspan="19">Visual customization</th>
					</tr>
					<tr>
						<th>Brand</th>
						<th>Model</th>
						<th>Year</th>
						<th>Price</th>
						<th>Transmission</th>
						
						<th>0-60 (s)</th>
						<th>1/4 mile</th>
						<th>Top speed (mph)</th>
						<th>Power (bhp)</th>

						<th>0-60 (s)</th>
						<th>1/4 mile</th>
						<th>Top speed (mph)</th>
						<th>Power (bhp)</th>
						
						<th>Total</th>
						<th>Body kits</th>
						<th>Front Bumper</th>
						<th>Rear Bumper</th>
						<th>Side Skirts</th>
						<th>Headlights</th>
						<th>Taillights</th>
						<th>Hood</th>
						<th>Splitter</th>
						<th>Front Fender</th>
						<th>Rear Fender</th>
						<th>Wing Mirrors</th>
						<th>Trunk Lid</th>
						<th>Spoiler</th>
						<th>Diffuser</th>
						<th>Exhaust</th>
						<th>Front Canards</th>
						<th>Rear Canards</th>
						<th>SoundSystem</th>
					</tr>
				</thead>
				<tbody>
					<xsl:apply-templates select="nfs2015Data/car" />
				</tbody>
			</table>
			<script type="text/javascript">
$(document).ready(function(){
    $('#car-data').DataTable({
		dom: "Bfrtip",
		paging: false,
		scrollX: true,
		scrollY: "500px", // TODO: compute automatically. Needs to be in pixels for the fixed header to render correctly
		scrollCollapse: true,
		buttons: [ 'colvis' ],
		fixedHeader: true,
		fixedColumns: {
            leftColumns: 2
        }/*,
		
		'drawCallback': function( settings ) {
			// TODO: fix scrolling header size
		}*/
	});
});


			</script>
		</body>
		</html>
	</xsl:template>
	
	<xsl:template match="/nfs2015Data/car">
		<tr>
			<td><xsl:value-of select="identification/brand"/></td>
			<td><span>
				<xsl:if test="@checkedVersion != /nfs2015Data/@lastGameVersion">
					<xsl:attribute name="class">outofdate</xsl:attribute>
					<xsl:attribute name="title">This data was checked for version <xsl:value-of select="@checkedVersion" /> but the latest game version is <xsl:value-of select="/nfs2015Data/@lastGameVersion" />.</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="identification/model"/>
				<xsl:if test="identification/designation"> (<xsl:value-of select="identification/designation"/>)</xsl:if>
			</span></td>
			<td><xsl:value-of select="identification/year"/></td>
			<td><xsl:value-of select="stats/price"/></td>
			<td><xsl:value-of select="stats/transmission"/></td>
			
			<td><xsl:value-of select="stats/stock/acceleration"/></td>
			<td>
				<xsl:attribute name="data-order"><xsl:value-of select="stats/stock/quarterMile/time"/></xsl:attribute>
				<xsl:value-of select="stats/stock/quarterMile/time"/> s @ <xsl:value-of select="stats/stock/quarterMile/speed"/> mph
			</td>
			<td><xsl:value-of select="stats/stock/topSpeed"/></td>
			<td><xsl:value-of select="stats/stock/power"/></td>
			
			<td><xsl:value-of select="stats/max/acceleration"/></td>
			<td>
				<xsl:attribute name="data-order"><xsl:value-of select="stats/max/quarterMile/time"/></xsl:attribute>
				<xsl:value-of select="stats/max/quarterMile/time"/> s @ <xsl:value-of select="stats/max/quarterMile/speed"/> mph
			</td>
			<td><xsl:value-of select="stats/max/topSpeed"/></td>
			<td><xsl:value-of select="stats/max/power"/></td>
			
			<td><xsl:value-of select="sum(visualParts/*)"/></td>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/bodyKit"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/frontBumper"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/rearBumper"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/sideSkirts"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/headlights"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/taillights"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/hood"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/splitter"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/frontFender"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/rearFender"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/wingMirrors"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/trunkLid"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/spoiler"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/diffuser"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/exhaust"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/frontCanards"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/rearCanards"/></xsl:call-template>
			<xsl:call-template name="visualPart"><xsl:with-param name="element" select="visualParts/soundSystem"/></xsl:call-template>
		</tr>
	</xsl:template>
	
	<xsl:template name="visualPart">
		<xsl:param name="element" />
		<td>
			<xsl:choose>
				<xsl:when test="$element='0'">
					<xsl:attribute name="class">bg-danger</xsl:attribute>
					<xsl:value-of select="$element" />
				</xsl:when>
				<xsl:when test="$element">
					<xsl:value-of select="$element" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">bg-warning</xsl:attribute>
					?
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</xsl:template>

</xsl:stylesheet>

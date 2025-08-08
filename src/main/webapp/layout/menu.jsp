<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="bg_nav">
	<div class="container-fluid m-0">
		<div class="row  no-gutters">
			<div class="col-md-7 col-xs-12">
				<nav class="main-nav" role="navigation ">
					<!-- Mobile menu toggle button (hamburger/x icon) -->
					<input id="main-menu-state" type="checkbox" /> <label
						class="main-menu-btn" for="main-menu-state"> <span
						class="main-menu-btn-icon"></span> Toggle main menu visibility
					</label>
					<c:if test="${AuthenticatedUser ne null}">
						<ul id="main-menu" class="sm sm-blue">
							<c:if test="${serviceMasters.size() >= 1}">
								<c:forEach var="i" begin="0" end="${serviceMasters.size()}">
									<c:if test="${serviceMasters[i].optionName != 'Home' && serviceMasters[i].parentId == 0}">
										<li><a
											href="${pageContext.request.contextPath}/${serviceMasters[i].url}">
												<c:out value="${serviceMasters[i].optionName}" />
										</a>
											<ul>
												<c:forEach var="j" begin="0" end="${serviceMasters.size()}">
													<c:if
														test="${serviceMasters[i].optionId eq serviceMasters[j].parentId}">
														<li><a
															href="${pageContext.request.contextPath}/${serviceMasters[j].url}">${serviceMasters[j].optionName}</a></li>
													</c:if>
												</c:forEach>
											</ul></li>
									</c:if>
									<c:if
										test="${serviceMasters[i].optionName == 'Home' && serviceMasters[i].parentId == 0}">
										<li><a
											href="${pageContext.request.contextPath}/${serviceMasters[i].url}">
												<c:out value="${serviceMasters[i].optionName}" />
										</a></li>
									</c:if>
								</c:forEach>
							</c:if>

							<!-- <li><a href="#"><i class="fa fa-user" aria-hidden="true"
												style="font-size: 20px;"></i></a>
										<ul>
											<li>
											<li><a href="${pageContext.request.contextPath}/logout">Logout</a>
											</li>
										</ul>
									</li> -->
						</ul>
					</c:if>
				</nav>
			</div>
			<div class="col-md-5">
				<ul id="main-menu" class="sm sm-blue"
					style="margin-left: 60px; float: inline-end;">
					<c:if test="${AuthenticatedUser ne null}">
						<li><a href="#">Welcome : ${AuthenticatedUser} </a></li>
						<li><a href="${pageContext.request.contextPath}/logout">Logout</a>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>




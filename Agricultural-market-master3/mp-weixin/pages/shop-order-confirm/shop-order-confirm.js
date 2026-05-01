(global["webpackJsonp"] = global["webpackJsonp"] || []).push([
	["pages/shop-order-confirm/shop-order-confirm"], {
		"1f98": function(e, t, r) {
			"use strict";
			var a = r("f4a7"),
				o = r.n(a);
			o.a
		},
		"27e5": function(e, t, r) {
			"use strict";
			(function(e) {
				r("6cdc"), r("921b");
				a(r("66fd"));
				var t = a(r("b1b8"));

				function a(e) {
					return e && e.__esModule ? e : {
						default: e
					}
				}
				e(t.default)
			}).call(this, r("543d")["createPage"])
		},
		"83fd": function(e, t, r) {
			"use strict";
			r.r(t);
			var a = r("d682"),
				o = r.n(a);
			for (var n in a) "default" !== n && function(e) {
				r.d(t, e, (function() {
					return a[e]
				}))
			}(n);
			t["default"] = o.a
		},
		b1b8: function(e, t, r) {
			"use strict";
			r.r(t);
			var a = r("f4dc"),
				o = r("83fd");
			for (var n in o) "default" !== n && function(e) {
				r.d(t, e, (function() {
					return o[e]
				}))
			}(n);
			r("1f98");
			var s, d = r("f0c5"),
				i = Object(d["a"])(o["default"], a["b"], a["c"], !1, null, null, null, !1, a["a"], s);
			t["default"] = i.exports
		},
		d682: function(e, t, r) {
			"use strict";
			(function(e) {
				Object.defineProperty(t, "__esModule", {
					value: !0
				}), t.default = void 0;
				var a = o(r("a34a"));

				function o(e) {
					return e && e.__esModule ? e : {
						default: e
					}
				}

				function n(e, t, r, a, o, n, s) {
					try {
						var d = e[n](s),
							i = d.value
					} catch (u) {
						return void r(u)
					}
					d.done ? t(i) : Promise.resolve(i).then(a, o)
				}

				function s(e) {
					return function() {
						var t = this,
							r = arguments;
						return new Promise((function(a, o) {
							var s = e.apply(t, r);

							function d(e) {
								n(s, a, o, d, i, "next", e)
							}

							function i(e) {
								n(s, a, o, d, i, "throw", e)
							}
							d(void 0)
						}))
					}
				}
				var d = {
					data: function() {
						return {
							user: {},
							orderGoods: [],
							address: {},
							total: 0,
							originalTotal: 0,
							type: 1,
							seat: 0,
							remark: "",
							paytype: '现金支付',
							groupId: null
						}
					},
					computed: {
						baseUrl: function() {
							return this.$base.url
						}
					},
					onLoad: function() {
						var t = s(a.default.mark((function t(r) {
							var o, now, total, res, detail;
							return a.default.wrap((function(t) {
								while (1) switch (t.prev = t.next) {
									case 0:
										this.type = r.type, this.seat = r.seat, this.orderGoods = e.getStorageSync("orderGoods");
										now = new Date().getTime();
										total = 0;
										if (1 == this.seat) { t.next = 23; break; }
										o = 0;
									case 6:
										if (!(o < this.orderGoods.length)) { t.next = 21; break; }
										t.next = 9;
										return this.$api.info(this.orderGoods[o].tablename, this.orderGoods[o].goodid);
									case 9:
										res = t.sent;
										detail = res.data;
										if (detail) {
											let item = this.orderGoods[o];
											let price = parseFloat(detail.price || item.price);
											let startTime = detail.reducestarttime;
											let endTime = detail.reduceendtime;
											if (typeof startTime === 'string') startTime = startTime.replace(/-/g, '/');
											if (typeof endTime === 'string') endTime = endTime.replace(/-/g, '/');

											// 判断折扣逻辑
											if (detail.reducediscount && parseFloat(detail.reducediscount) < 1 && startTime && endTime) {
												let start = new Date(startTime).getTime();
												let end = new Date(endTime).getTime();
												if (now >= start && now <= end) {
													price = price * parseFloat(detail.reducediscount);
													item.price = price.toFixed(2);
													item.isDiscount = true; 
                                                    // --- 在这里添加显眼的文字标记 ---
                                                    if(!item.goodname.includes("【限时优惠】")){
                                                        item.goodname = "【限时优惠】" + item.goodname;
                                                    }
												}
											}
											total += price * item.buynumber;
										}
										o++;
										t.next = 6;
										break;
									case 21:
										t.next = 25;
										break;
									case 23:
										total = parseFloat(this.orderGoods[0].total), this.address = this.orderGoods[0].address;
									case 25:
										this.total = total.toFixed(2), this.originalTotal = this.total;
									case 27:
									case "end":
										return t.stop()
								}
							}), t, this)
						})));

						function r(e) {
							return t.apply(this, arguments)
						}
						return r
					}(),
					onShow: function() {
						var t = s(a.default.mark((function t() {
							var r, o, n;
							return a.default.wrap((function(t) {
								while (1) switch (t.prev = t.next) {
									case 0:
										return r = e.getStorageSync("nowTable"), t.next = 3, this.$api.session(r);
									case 3:
										if (o = t.sent, this.user = o.data, 1 == this.seat) {
											t.next = 15;
											break
										}
										if (n = e.getStorageSync("address"), !n || this.user.id != n.userid) {
											t.next = 11;
											break
										}
										this.address = e.getStorageSync("address"), t.next = 15;
										break;
									case 11:
										return t.next = 13, this.$api.defaultAddress(this.user.id);
									case 13:
										o = t.sent, this.address = o.data;
									case 15:
									case "end":
										return t.stop()
								}
							}), t, this)
						})));

						function r() {
							return t.apply(this, arguments)
						}
						return r
					}(),
					methods: {
						onPayTypeChange: function(e) {
							this.paytype = e.detail.value;
							this.type = (this.paytype == '积分支付') ? 2 : 1;
						},
						onGroupChange: function(e) {
							this.groupId = e.detail.value.length > 0 ? 1001 : null;
							if (this.groupId) {
								this.total = (parseFloat(this.originalTotal) * 0.7).toFixed(2);
							} else {
								this.total = this.originalTotal;
							}
						},
						onSubmitTap: function() {
							var t = s(a.default.mark((function t() {
								var r, o;
								return a.default.wrap((function(t) {
									while (1) switch (t.prev = t.next) {
										case 0:
											if (r = this, 1 == r.seat || r.address.address) {
												t.next = 4;
												break
											}
											return r.$utils.msg("请选择地址"), t.abrupt("return");
										case 4:
											o = e.getStorageSync("nowTable"), e.showModal({
												title: "提示",
												content: "是否确认支付",
												success: function() {
													var t = s(a.default.mark((function t(n) {
														var s, d, i, u, c, l;
														return a.default.wrap((function(t) {
															while (1) switch (t.prev = t.next) {
																case 0:
																	if (!n.confirm) {
																		t.next = 65;
																		break
																	}
																	s = r.type;
																	d = !0;
																	i = (r.paytype == '积分支付' ? "已支付" : "未支付");
																	if (r.paytype == '积分支付') {
																		if (r.user.jifen - r.total < 0) {
																			r.$utils.msg("积分不足"), d = !1, t.abrupt("return");
																		}
																	}
																	t.next = 13;
																	break;
																case 13:
																	u = 0;
																case 14:
																	if (!(u < r.orderGoods.length)) {
																		t.next = 51;
																		break
																	}
																	l = {
																		orderid: r.$utils.genTradeNo(),
																		tablename: r.orderGoods[u].tablename,
																		userid: r.user.id,
																		goodid: r.orderGoods[u].goodid,
																		goodname: r.orderGoods[u].goodname,
																		picture: r.orderGoods[u].picture,
																		buynumber: r.orderGoods[u].buynumber,
																		price: r.orderGoods[u].price,
																		total: r.total,
																		type: s,
																		paytype: r.paytype,
																		groupId: r.groupId,
																		status: i,
																		remark: r.orderGoods[u].isDiscount ? "【限时降价优惠】" : r.remark,
																		address: r.address.address,
																		tel: r.address.phone,
																		consignee: r.address.name,
																		goodtype: r.orderGoods[u].goodtype
																	}, t.next = 44, r.$api.add("orders", l);
																case 44:
																	u++, t.next = 14;
																	break;
																case 51:
																	if (!d) {
																		t.next = 65;
																		break
																	}
																	if (r.paytype != '积分支付') {
																		r.$utils.msgBack("支付成功"), r.user.money = r.user.money - r.total;
																	} else {
																		r.$utils.msgBack("兑换成功"), r.user.jifen = r.user.jifen - r.total;
																	}
																	return t.next = 58, r.$api.update(o, r.user);
																case 58:
																	t.next = 65;
																	break;
																case 65:
																case "end":
																	return t.stop()
															}
														}), t)
													})));

													function n(e) {
														return t.apply(this, arguments)
													}
													return n
												}()
											});
										case 6:
										case "end":
											return t.stop()
									}
								}), t, this)
							})));

							function r() {
								return t.apply(this, arguments)
							}
							return r
						}(),
						onAddressTap: function() {
							this.$utils.jump("../shop-address/shop-address")
						}
					}
				};
				t.default = d
			}).call(this, r("543d")["default"])
		},
		f4a7: function(e, t, r) {},
		f4dc: function(e, t, r) {
			"use strict";
			var a, o = function() {
					var e = this,
						t = e.$createElement;
					e._self._c
				},
				n = [];
			r.d(t, "b", (function() {
				return o
			})), r.d(t, "c", (function() {
				return n
			})), r.d(t, "a", (function() {
				return a
			}))
		}
	},
	[
		["27e5", "common/runtime", "common/vendor"]
	]
]);
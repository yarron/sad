<?php /* robokassa metka */ ?>
      <div class="buttons">
		<?php if( $robokassa_confirm_status=='before' || $robokassa_confirm_status=='premod' ) { ?>
		<div class="right"><a onclick="makePreorder();" class="button"><span><?php echo $button_confirm; ?></span></a></div>
		<?php } else { ?>
		<div class="right"><a onclick="location='<?php echo $robokassa_link; ?>'" class="button"><span><?php echo $button_confirm; ?></span></a></div>
		<?php } ?>
	  </div>
	  
<?php if( $robokassa_confirm_status=='before' || $robokassa_confirm_status=='premod' ) { ?>
<script>
	function makePreorder()
	{
		$.ajax({
					url: 'index.php?route=payment/robokassa/preorder',
					dataType: 'html',	
					data: { 
						MrchLogin: "<?php echo $MrchLogin; ?>", 
						OutSum: "<?php echo $OutSum; ?>", 
						InvId: "<?php echo $InvId; ?>", 
						Desc: "<?php echo $Desc; ?>", 
						Email: "<?php echo $Email; ?>", 
						SignatureValue: "<?php echo $SignatureValue; ?>", 
						Shp_item: "<?php echo $Shp_item; ?>", 
						IncCurrLabel: "<?php echo $IncCurrLabel; ?>", 
						Culture: "<?php echo $Culture; ?>"					
					},
					success: function(html) {
						<?php if( $robokassa_confirm_status=='before' ) { ?>
						location = '<?php echo $robokassa_link; ?>';
						<?php } else { ?>
						location = '<?php echo $continue; ?>';
						<?php } ?>
					
					},
					error: function(xhr, ajaxOptions, thrownError) {
						//alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
		});	
	}
	
</script>
<?php } ?>
require 'aws-sdk-ec2'
require 'time'

region_name = [ 'eu-central-1','eu-west-1','eu-west-2','eu-west-3','eu-north-1',
                'us-east-2','us-east-1','us-west-1','us-west-2','ap-south-1',
                'ap-northeast-2','ap-southeast-1','ap-southeast-2','ap-northeast-1','ca-central-1','sa-east-1'
              ]

region_name.each do |r|
  puts "\nCheck region #{r} \n"
  ec2 = Aws::EC2::Client.new( region: r, access_key_id: access_key_id, secret_access_key: secret_access_key )

  ec2.describe_instances[:reservations].each do |i|
    i[:instances].first[:tags].each do |t|
      if  t[:key] == 'expiration_date' and Date.parse(t[:value])  < ( Date.today + 7 )
        puts "Instance ID #{i[:instances].first[:instance_id]} must be stopped"
      end
    end
  end
end
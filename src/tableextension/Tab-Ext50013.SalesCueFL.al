tableextension 50013 "Sales Cue FL" extends "Sales Cue"
{
    fields
    {
        field(50000; "MySpareParts Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'My Spare Parts Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter("Spare Parts"), Status = filter(Open), "Prepared by" = field("User ID Filter")));
        }
        field(50001; "MyPendingSparePrt Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'My Pending Spare Parts Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter("Spare Parts"), Status = filter("Pending Approval"), "Prepared by" = field("User ID Filter")));
        }
        field(50002; "MyApprovedSparePt Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'My Approved Spare Parts Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter("Spare Parts"), Status = filter(Released), "Transferred" = const(false),"Converted to Quote" = const(false), "Prepared by" = field("User ID Filter")));
        }
        field(50059; "MyConsumedSparePt Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'My Consumed Spare Parts Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter("Spare Parts"), Status = filter(Released), "Transferred" = const(true), "Prepared by" = field("User ID Filter")));
        }
        field(50060; "MyPurchSparePt Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'My Purchased Spare Parts Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter("Spare Parts"), Status = filter(Released),"Converted to Quote" = const(true), "Prepared by" = field("User ID Filter")));
        }
        field(50003; "AllSpareParts Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'All Spare Parts Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter("Spare Parts")));
        }
        field(50004; "AllPendingSparePt Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'My Pending Spare Parts Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter("Spare Parts"), Status = filter("Pending Approval")));
        }
        field(50005; "AllApprovedSparPt Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'My Approved Spare Parts Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter("Spare Parts"), Status = filter(Released)));
        }
        // Fuel Requisitions==========
        field(50006; "Fuel Requisitions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Store Requisition"), "Request Type" = filter(Fuel), "Prepared by" = field("User ID Filter") ,"Status"= const("Open")));
        }
        field(50007; "Pending Fuel Requisitions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Store Requisition"), Status = filter("Pending Approval"), "Request Type" = filter(Fuel), "Prepared by" = field("User ID Filter")));
        }
        field(50008; "Approved Fuel Requisitions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Store Requisition"), Status = filter(Released), "Request Type" = filter(Fuel), "Prepared by" = field("User ID Filter")));
        }
        field(50061; "Rejected Fuel Requisitions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Store Requisition"), Status = filter(Rejected), "Request Type" = filter(Fuel), "Prepared by" = field("User ID Filter")));
        }
        field(50009; "All Fuel Requisitions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Store Requisition"), "Request Type" = filter(Fuel)));
        }
        field(50010; "All Pending Fuel Requisitions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Store Requisition"), Status = filter("Pending Approval"), "Request Type" = filter(Fuel)));
        }
        field(50011; "All Approved Fuel Requisitions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Store Requisition"), Status = filter(Released), "Request Type" = filter(Fuel)));
        }
        field(50012; Drivers; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Employee Type" = filter('DRIVER')));
        }
        field(50013; "Expired Licenses"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Days to License expiry" = filter(<= 0), "Driving License ID" = filter(<> ''), "License validity Start Date" = filter(<> 0D), "Employee Type" = filter('DRIVER'), "License Expired" = const(true)));
        }
        field(50014; "Licenses Expiring Today"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Days to License expiry" = filter(= 0), "Driving License ID" = filter(<> ''), "License validity Start Date" = filter(<> 0D), "Employee Type" = filter('DRIVER')));
        }
        field(50015; "LicensesExpiringWithin 3Months"; Integer)
        {
            Caption = 'Licenses Expiring Within 3 Months';
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Days to License expiry" = filter(<= 90), "Driving License ID" = filter(<> ''), "License validity Start Date" = filter(<> 0D), "Employee Type" = filter('DRIVER')));
        }
        field(50020; Equipments; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Asset");
        }
        field(50021; "Equipments Available"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Asset" where("Equipment Status" = filter(Available)));
        }
        field(50022; "Equipments In Use"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Asset" where("Equipment Status" = filter("In Use")));
        }
        field(50023; "Equipments At Workshop"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Asset" where("Equipment Status" = filter("At Workshop")));
        }
        field(50024; "Equipments Not in Operation"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Asset" where("Equipment Status" = filter("Not in Operation")));
        }

        // Maintenance Request==========
        field(50030; "Maintenance Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Maintenance Request"), Status = filter("Open"), "Prepared by" = field("User ID Filter")));
        }
        field(50031; "Pending Maintenance Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Maintenance Request"), Status = filter("Pending Approval"), "Prepared by" = field("User ID Filter")));
        }
        field(50032; "Approved Maintenance Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Maintenance Request"), Status = filter(Released), "Prepared by" = field("User ID Filter")));
        }
        field(50033; "All Maintenance Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Maintenance Request")));
        }
        field(50034; "AllPendingMaintenanceRequests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Maintenance Request"), Status = filter("Pending Approval")));
        }
        field(50035; "AllApprovedMaintenanceRequests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Maintenance Request"), Status = filter(Released)));
        }

        //Maintenance Jobs==========
        field(50040; "All Maintenance Jobs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Job Card")));
        }
        field(50041; "New Maintenance Jobs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Job Card"), "Job Status" = filter(New)));
        }
        field(50042; "Closed Maintenance Jobs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Job Card"), "Job Status" = filter(Closed)));
        }
        field(50043; "Cancelled Maintenance Jobs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Job Card"), "Job Status" = filter(Cancelled)));
        }
        field(50044; "In Progress Maintenance Jobs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Maintenance Header" where("Document Type" = filter("Job Card"), "Job Status" = filter("In Progress")));
        }
        field(50045; "All General Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'All General Requisitions';
            CalcFormula = count("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Request Type" = filter(General)));
        }
        field(50046; "All HandOver Requisitions"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'All Hand Over Requisitions';
            CalcFormula = count("Form Header" where("Document Type" = filter("Equipment Hand Over")));
        }
        field(50047; "Active Drivers"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Available Drivers';
            CalcFormula = count(Employee where("Driver Status" = filter(Active), "Employee Type" = filter('DRIVER'), "License expired" = const(false),"Defensive Driving Days" = filter(>0), "Medical Fitness Days" = filter(>0)));
        }
        // field(50048; "Inactive Drivers"; Integer)
        // {
        //     FieldClass = FlowField;
        //     Caption = 'Inactive Drivers';
        //     CalcFormula = count(Employee where("Driver Status" = filter(Inactive), "Employee Type" = filter('DRIVER')));
        // }
        // field(50049; "Terminated Drivers"; Integer)
        // {
        //     FieldClass = FlowField;
        //     Caption = 'Terminated Drivers';
        //     CalcFormula = count(Employee where("Driver Status" = filter(Terminated), "Employee Type" = filter('DRIVER')));
        // }
        field(50050; "Drivers On Leave"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Drivers On Leave';
            CalcFormula = count(Employee where("Driver Status" = filter(OnLeave), "Employee Type" = filter('DRIVER')));
        }

        field(50051; "Expired Medical Licenses"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Medical Fitness Days" = filter(<= 0), "Fitness Validity End Date" = filter(<> 0D), "Employee Type" = filter('DRIVER')));
        }
        field(50052; "Medical Licenses ExpiringToday"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Medical Licenses Expiring Today';
            CalcFormula = count(Employee where("Medical Fitness Days" = filter(= 0), "Fitness Validity End Date" = filter(<> 0D), "Employee Type" = filter('DRIVER')));
        }
        field(50053; "MedLicenseExpiringWith3Months"; Integer)
        {
            Caption = 'Medical Licenses Expiring Within 3 Months';
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Medical Fitness Days" = filter(<= 90), "Fitness Validity End Date" = filter(<> 0D), "Employee Type" = filter('DRIVER')));
        }
        field(50054; "Expired Defensive Licenses"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Defensive Driving Days" = filter(<= 0), "DefensiveDrive ValidEndDate" = filter(<> 0D), "Employee Type" = filter('DRIVER')));
        }
        field(50055; "Defensive LicensesExpireToday"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Defensive Driving Expiring Today';
            CalcFormula = count(Employee where("Defensive Driving Days" = filter(= 0), "DefensiveDrive ValidEndDate" = filter(<> 0D), "Employee Type" = filter('DRIVER')));
        }
        field(50056; "DefLicenseExpiringWith3Months"; Integer)
        {
            Caption = 'Defensive Driving Licenses Expiring Within 3 Months';
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Defensive Driving Days" = filter(<= 90), "DefensiveDrive ValidEndDate" = filter(<> 0D), "Employee Type" = filter('DRIVER')));
        }
        field(50057; "All Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee);
        }
        field(50058; "Equipments Due for Servicing"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Equipment Due for Servicing';
            //CalcFormula = count(Employee where("Employee Status" = filter(Active)));
            CalcFormula = count("Fixed Asset" where("Serviced"= const(false)));

        }
    }

}